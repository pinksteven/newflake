{
  config,
  lib,
  ...
}: let
  inherit (config.lib.stylix) colors;
  inherit (config.stylix) opacity;

  rgb = color: "rgb(${color})";
  rgba = color: alpha: "rgba(${color}${lib.toHexString (builtins.ceil (alpha * 255))})";
in {
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 10;
      gaps_out = 5;
      border_size = 2;
      "col.active_border" = "${rgb colors.base0C} ${rgb colors.base0D} ${rgb colors.base0E} 45deg";
      "col.inactive_border" = rgb colors.base03;
    };
    decoration = {
      active_opacity = opacity.applications;
      inactive_opacity = opacity.applications * 0.66;
      rounding = 15;
      shadow = {
        enabled = true;
        range = 20;
        render_power = 3;
        color = rgba colors.base00 0.8;
      };
      blur = {
        enabled = "true";
        size = 12;
        passes = 3;
      };
    };
    group = {
      "col.border_inactive" = rgb colors.base03;
      "col.border_active" = "${rgb colors.base0A} ${rgb colors.base09} ${rgb colors.base08} 45deg";
      "col.border_locked_active" = rgb colors.base08;
      groupbar = {
        text_color = rgb colors.base05;
        "col.active" = rgb colors.base09;
        "col.inactive" = rgb colors.base03;
      };
    };
    misc.background_color = rgb colors.base00;

    animations = {};
  };
}
