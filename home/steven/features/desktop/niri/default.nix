{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./animations.nix
    ./binds.nix
    ./layout.nix
    ./outputs.nix
    ./rules.nix
  ];

  home.packages = with pkgs; [xwayland-satellite niri];
  wayland.systemd.target = "niri.service";

  xdg.configFile."niri/config.kdl".text =
    ''
      include "binds.kdl"
      include "layout.kdl"
      include "outputs.kdl"
      include "rules.kdl"

      prefer-no-csd
      screenshot-path "~/Pictures/Screenshots/Screenshot_%Y-%m-%d_%H:%M:%S.png"
      xwayland-satellite { path "${lib.getExe pkgs.xwayland-satellite}"; }

      input {
          keyboard {
              xkb {
                  layout "pl"
                  model ""
                  rules ""
                  variant ""
              }
              repeat-delay 300
              repeat-rate 50
              track-layout "global"
              numlock
          }
          touchpad {
              tap
              drag true
              natural-scroll
              accel-profile "adaptive"
              scroll-method "two-finger"
              click-method "button-areas"
              tap-button-map "left-right-middle"
          }
          mouse { accel-profile "flat"; }
          focus-follows-mouse
          disable-power-key-handling
      }

    ''
    + lib.concatMapStringsSep "\n" (app: "spawn-sh-at-startup \"${app.startupCmd}\"")
    config.startupPrograms;
}
