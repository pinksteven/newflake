{pkgs, ...}: {
  home.packages = [pkgs.inputs.stasis.stasis];

  # Recommended by wiki systemd setup
  systemd.user.services.stasis = {
    Unit = {
      Description = "Stasis Wayland Idle Manager";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.inputs.stasis.stasis}/bin/stasis";
      Restart = "always";
      RestartSec = "5";
      Environment = "WAYLAND_DISPLAY=wayland-1";
      ExecStartPre = "/bin/sh -c 'while [ ! -e /run/user/%U/wayland-1 ]; do sleep 0.1; done'";
    };
    Install = {
      WantedBy = ["default.target"];
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
          r"firefox.*"
        ]

        dpms:
          timeout 600 # 10 minutes
          command "niri msg action power-off-monitors"
          resume-command "niri msg action power-on-monitors"
        end

        # laptop-only AC actions
        on_ac:

          # Step 1: Adjust brightness (instant)
          # define it first so it does not retrigger later
          custom-brightness-instant:
            timeout 0
            command "brightnessctl set 100%"
          end

          lock_screen:
            timeout 120
            command "hyprlock"
          end

          brightness:
            timeout 10
            command "brightnessctl set 30%"
          end

          dpms:
            timeout 60
            command "niri msg action power-off-monitors"
          end
        end

        # Laptop-only battery actions
        on_battery:
          custom-brightness-instant:
            timeout 0
            command "brightnessctl set 100%"
          end

          lock_screen:
            timeout 120 # 2 minutes
            command "hyprlock"
          end

          brightness:
            timeout 10
            command "brightnessctl set 30%"
          end

          dpms:
            timeout 60
            command "niri msg action power-off-monitors"
          end

          suspend:
            timeout 300 # 5 minutes
            command "systemctl suspend"
          end
        end
      end
    '';
}
