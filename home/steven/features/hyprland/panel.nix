{
  lib,
  monitors,
  config,
  ...
}: {
  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    settings = {
      bar = {
        clock.format = "%a %b %d  %H:%M";
        layouts = let
          primary = lib.head (lib.filter (m: m.primary) monitors);
          hasBattery = builtins.pathExists "/sys/class/power_supply/BAT0";
          hasBluetooth = builtins.pathExists "/sys/class/bluetooth";
        in {
          ${primary.name} = {
            left = ["workspaces"];
            middle = ["media"];
            right =
              lib.optional hasBluetooth "bluetooth"
              ++ ["network" "volume"]
              ++ lib.optional hasBattery "battery"
              ++ ["systray" "clock" "notifications" "power"];
          };
          "*" = {
            left = ["workspaces"];
            middle = [];
            right = ["clock" "notifications"];
          };
        };
      };
      theme = {
        font = {
          inherit (config.stylix.fonts.sansSerif) name;
          size = "0.9rem";
        };
        bar = {
          floating = true;
          margin_top = "0.0em";
          border_radius = "1.0em";
        };
      };
      menus = {
        clock = {
          weather.enabled = false;
          time = {
            military = true;
            hideSeconds = true;
          };
        };
      };
    };
  };
}
