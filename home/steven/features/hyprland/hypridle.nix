{pkgs, ...}: let
  hasBattery = builtins.pathExists "/sys/class/power_supply/BAT0";
in {
  services.hypridle = {
    enable = hasBattery;
    settings = {
      general = {
        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }

        {
          timeout = 600;
          on-timeout = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
        }

        {
          timeout = 660;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }

        {
          timeout = 900;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
