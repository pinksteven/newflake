{
  config,
  monitors,
  lib,
  ...
}: {
  stylix.targets.hyprlock.enable = false;
  programs.hyprlock = {
    enable = true;
    settings = let
      rgb = color: "rgb(${color})";
      rgba = color: alpha: "rgba(${color}${lib.toHexString (builtins.ceil (alpha * 255))})";

      inherit (config.lib.stylix) colors;
      font = config.stylix.fonts.serif.name;
      primaryMonitor = lib.head (lib.filter (m: m.primary) monitors);
    in {
      auth.fingerprint = {
        enabled = true;
        ready_message = "(Scan fingerprint to unlock)";
        present_message = "Scanning fingerprint";
      };

      background = {
        path = config.stylix.image;
        color = rgb colors.base00;
        blur_passes = 3;
        blur_size = 4;
        contrast = 1.3;
        brightness = 0.8;
        vibrancy = 0.21;
        vibrancy_darkness = 0.0;
      };

      input-field = [
        {
          monitor = primaryMonitor.name;
          size = "400, 90";
          outline_thickness = 3;
          dots_size = 0.25; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          outer_color = rgb colors.base0D;
          inner_color = rgba colors.base01 0.8;
          font_color = rgb colors.base05;
          fade_on_empty = true;
          font_family = font + " Bold";
          hide_input = false;
          capslock_color = rgb colors.base08;
          position = "0, -100";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        # TIME
        {
          text = ''$TIME'';
          color = rgb colors.base05;
          font_size = 40;
          font_family = font + "Bold";
          shadow_passes = 3;
          shadow_size = 1;
          position = "0, 100";
          halign = "center";
          valign = "center";
        }
        # DATE
        {
          text = ''cmd[update:1000] echo -e "$(date +"%A %d %B")"'';
          color = rgb colors.base05;
          font_size = 16;
          font_family = font;
          shadow_passes = 3;
          shadow_size = 1;
          position = "0, 0";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
