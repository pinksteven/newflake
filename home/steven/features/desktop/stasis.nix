{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}: let
  hasBattery = osConfig.hardware.capabilities.hasBattery or false;
in {
  home.packages = [pkgs.inputs.stasis.stasis];

  # Recommended by wiki systemd setup
  systemd.user.services.stasis = lib.mkIf hasBattery {
    Unit = {
      Description = "Stasis Wayland Idle Manager";
      ConditionEnvironment = "WAYLAND_DISPLAY";
      PartOf = [config.wayland.systemd.target];
      After = [config.wayland.systemd.target];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.inputs.stasis.stasis}/bin/stasis";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [config.wayland.systemd.target];
    };
  };

  xdg.configFile."stasis/stasis.rune".text =
    # rune
    ''
      # Default timeout for apps (in seconds)
      app_default_timeout 300

      #
      # Stasis configuration
      #
      stasis:
        pre_suspend_command "hyprlock"
        monitor_media true
        ignore_remote_media true
        respect_idle_inhibitors true

        lid_close_action "suspend"
        lid_open_action "wake"

        inhibit_apps [
          "vlc"
          "mpv"
          r".*\.exe"
          r"steam_app_.*"
        ]

        dpms:
          timeout 600 # 10 minutes
          command "niri msg action power-off-monitors"
          resume-command "niri msg action power-on-monitors"
        end

        # laptop-only AC actions
        on_ac:
          lock_screen:
            timeout 120
            command "hyprlock"
          end

          brightness:
            timeout 10
            command "brightnessctl -s set 30%"
            resume-command "brightnessctl -r"
          end

          dpms:
            timeout 60
            command "niri msg action power-off-monitors"
            resume-command "niri msg action power-on-monitors"
          end
        end

        # Laptop-only battery actions
        on_battery:
          lock_screen:
            timeout 120 # 2 minutes
            command "hyprlock"
          end

          brightness:
            timeout 10
            command "brightnessctl -s set 10%"
            resume-command "brightnessctl -r"
          end

          dpms:
            timeout 60
            command "niri msg action power-off-monitors"
            resume-command "niri msg action power-on-monitors"
          end

          suspend:
            timeout 300 # 5 minutes
            command "systemctl suspend"
          end
        end
      end
    '';
}
