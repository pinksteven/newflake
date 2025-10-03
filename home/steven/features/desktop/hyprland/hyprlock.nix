{
  config,
  lib,
  pkgs,
  ...
}: let
  rgb = color: "rgb(${color})";

  inherit (config.lib.stylix) colors;
  imageStr = toString config.stylix.image;
  font = config.stylix.fonts.serif.name;
in {
  stylix.targets.hyprlock.enable = false;
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        grace = 2;
        hide_cursor = true;
        disable_loading_bar = false;
      };
      auth.fingerprint = {
        enabled = true;
        ready_message = "(Scan fingerprint to unlock)";
        present_message = "Scanning fingerprint";
      };

      animations = {
        enabled = true;
      };

      background = {
        path = imageStr;
        color = rgb colors.base00;
        blur_passes = 3;
        blur_size = 4;
        contrast = 1.3;
        brightness = 0.8;
        vibrancy = 0.21;
        vibrancy_darkness = 0.0;
      };

      label = [
        # HOUR
        {
          text = ''cmd[update:1000] echo -e "$(date +"%H")"'';
          color = rgb colors.base0D;
          font_size = 250;
          font_family = font + " Bold";
          shadow_passes = 3;
          shadow_size = 2;
          position = "0, 250";
          halign = "center";
          valign = "center";
        }
        # MINUTES
        {
          text = ''cmd[update:1000] echo -e "$(date +"%M")"'';
          color = rgb colors.base05;
          font_size = 250;
          font_family = font + " Bold";
          shadow_passes = 3;
          shadow_size = 2;
          position = "0, -20";
          halign = "center";
          valign = "center";
        }
        # DATE
        {
          text = ''cmd[update:1000] echo -e "$(date +"%A %d %B")"'';
          color = rgb colors.base05;
          font_size = 16;
          font_family = font + " Bold";
          shadow_passes = 3;
          shadow_size = 1;
          position = "25, -25";
          halign = "left";
          valign = "top";
        }
        # UTILS
        {
          text = ''cmd[update:1000] echo -e "󰂀 $(cat /sys/class/power_supply/BAT1/capacity)%  󰕾 $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')%  󰖨 $(brightnessctl i -m | awk -F, '{print $4}')"'';
          color = rgb colors.base05;
          font_size = 16;
          font_family = font + " Bold";
          shadow_passes = 3;
          shadow_size = 1;
          position = "-25, -25";
          halign = "right";
          valign = "top";
        }
        # PAM OUTPUT
        {
          monitor = "";
          text = ''$FPRINTPROMPT<br/><span foreground="##${colors.base08}">$FAIL</span>'';
          color = rgb colors.base05;
          text_align = "center";
          font_size = 16;
          font_family = font;
          position = "0, 5";
          halign = "center";
          valign = "bottom";
        }
        # MUSIC
        {
          text = ''cmd[update:1000] echo -e "$(${lib.getExe pkgs.playerctl} metadata --format '{{artist}}  <span size="400%" rise="-33pt" foreground="##${colors.base0D}"></span>  {{title}}')"'';
          color = rgb colors.base05;
          font_size = 22;
          shadow_passes = 3;
          shadow_size = 1;
          font_family = font + " Bold";
          position = "0, 50";
          halign = "center";
          valign = "bottom";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "300, 60";
          outline_thickness = 2;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          outer_color = "rgba(255, 255, 255, 0)";
          inner_color = "rgba(255, 255, 255, 0)";
          font_color = rgb colors.base0D;
          fade_on_empty = false;
          font_family = font + " Bold";
          placeholder_text = "";
          hide_input = false;
          position = "0, -200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
