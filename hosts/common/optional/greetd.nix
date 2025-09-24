{
  config,
  lib,
  pkgs,
  ...
}: let
  hyprland-config = pkgs.writeText "greetd.conf" ''
    exec-once = regreet; hyprctl dispatch exit
    misc {
        disable_hyprland_logo = true
        disable_splash_rendering = true
        disable_hyprland_qtutils_check = true
    }
    animations {
      enabled = false
    }
  '';
in {
  users.extraUsers.greeter = {
    # For caching and such
    home = "/tmp/greeter-home";
    createHome = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.hyprland} --config ${hyprland-config}";
        user = config.users.extraUsers.greeter.name;
      };
    };
  };

  programs.regreet = {
    enable = true;
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

  security.pam.services.greetd.fprintAuth = false;
}
