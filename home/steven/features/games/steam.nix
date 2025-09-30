{
  config,
  lib,
  ...
}: let
  hasNiri = lib.attrByPath ["programs" "niri" "enable"] false config;
in {
  # Steam is basically installed already
  home.persistence = {
    "/persist/home/steven".directories = [
      ".local/share/Steam"
      ".local/share/icons/hicolor" # Steam holds it's icons here
    ];
  };

  # Hyprland configuration
  wayland.windowManager.hyprland.settings.exec-once = ["uwsm app -- steam -silent"];

  # Niri configuration (only when niri is available)
  programs.niri.settings = lib.mkIf hasNiri {
    spawn-at-startup = [
      {
        command = ["steam" "-silent"];
      }
    ];
  };
}
