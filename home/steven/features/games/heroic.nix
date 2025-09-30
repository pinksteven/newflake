{
  config,
  lib,
  pkgs,
  ...
}: let
  hasNiri = lib.attrByPath ["programs" "niri" "enable"] false config;
in {
  home.packages = [pkgs.heroic];

  home.persistence."/persist/home/steven" = {
    # Persisit entire heroic dir (can't be bothered to seperate cache)
    directories = [".config/heroic"];
  };

  # Remember to enable "Start Minimized" in heroic settings (can't do it any other tp start in tray)
  # Hyprland configuration
  wayland.windowManager.hyprland.settings.exec-once = ["uwsm app -- heroic"];

  # Niri configuration (only when niri is available)
  programs.niri.settings = lib.mkIf hasNiri {
    spawn-at-startup = [
      {
        command = ["heroic"];
      }
    ];
  };
}
