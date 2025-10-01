{
  config,
  lib,
  pkgs,
  ...
}: {
  services = {
    greetd.enable = true;
    # When running greetd the assumption is there will be a graphical session
    # some apps in said graphical session might use libsecrets so we enable gnome-keyring for it
    gnome.gnome-keyring.enable = true;
  };

  programs.regreet = {
    enable = true;
    cageArgs = ["-s" "-m" "last"];
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

  # Adds Niri option if Niri enabled on any hm user
  services.displayManager.sessionPackages =
    lib.optional
    (builtins.any
      (cfg: lib.attrByPath ["programs" "niri" "enable"] false cfg)
      (builtins.attrValues config.home-manager.users))
    pkgs.niri-stable;

  # Adds Hyprland option if Hyprland enabled on any hm user
  programs.hyprland = lib.mkIf (builtins.any (config: config.wayland.windowManager.hyprland.enable)
    (builtins.attrValues config.home-manager.users)) {
    enable = true;
    withUWSM = true;
  };

  security.pam.services.greetd = {
    fprintAuth = false;
    # Truly don't want to put password multiple times
    enableGnomeKeyring = true;
  };
}
