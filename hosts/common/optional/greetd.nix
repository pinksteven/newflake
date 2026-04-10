{
  config,
  lib,
  pkgs,
  ...
}: let
  greetd-autologin = {
    inherit (config.services.greetd) settings;
    initial-session = {
      user = "steven";
      command = "niri-session";
    };
  };
  toml = pkgs.formats.toml {};
  autologin-toml = toml.generate "autologin.toml" greetd-autologin;
  greetd-toml = toml.generate "greetd.toml" config.services.greetd.settings;

  # This is a hacky way to actually login to graphical session via ssh
  # So that sunshine can work
  login-steven = pkgs.writeShellScriptBin "login-steven" ''
    touch /run/greetd-autologin
    systemctl restart greetd
  '';
in {
  environment.systemPackages = [login-steven];
  services = {
    greetd.enable = true;
    # When running greetd the assumption is there will be a graphical session
    # some apps in said graphical session might use libsecrets so we enable gnome-keyring for it
    gnome.gnome-keyring.enable = true;
  };

  programs.regreet = {
    enable = true;
    cageArgs = ["-s" "-d" "-m" "last"];
  };

  environment.persistence = {
    # Persist last user and last selected session
    "/persist".directories = [
      {
        directory = "/var/lib/regreet";
        user = "greeter";
        group = "greeter";
      }
    ];
  };

  systemd.services.greetd.serviceConfig.ExecStart = lib.mkForce (pkgs.writeShellScript "greetd-wrapper" ''
    TRIGGER="/run/greetd-autologin"

    if [ -f "$TRIGGER" ]; then
      echo "Autologin mode"
      rm "$TRIGGER"
      exec ${pkgs.greetd}/bin/greetd --config ${autologin-toml}
    else
      echo "Normal mode"
      exec ${pkgs.greetd}/bin/greetd --config ${greetd-toml}
    fi
  '');

  # Adds Niri option if Niri enabled on any hm user
  services.displayManager.sessionPackages =
    lib.optional
    (builtins.any
      (cfg: builtins.elem pkgs.niri (cfg.home.packages or []))
      (builtins.attrValues config.home-manager.users))
    pkgs.niri;

  security.pam.services.greetd = {
    fprintAuth = false;
    # Truly don't want to put password multiple times
    enableGnomeKeyring = true;
  };
}
