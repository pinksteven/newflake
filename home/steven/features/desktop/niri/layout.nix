{config, ...}: let
  colors = config.lib.stylix.colors.withHashtag;
in {
  programs.niri.settings.layout = {
    gaps = 10;
    always-center-single-column = true;
    preset-column-widths = [
      {proportion = 1. / 3.;}
      {proportion = 1. / 2.;}
      {proportion = 2. / 3.;}
    ];
    preset-window-heights = [
      {proportion = 1. / 3.;}
      {proportion = 1. / 2.;}
      {proportion = 2. / 3.;}
      {proportion = 1.;}
    ];
    default-column-width = {};

    focus-ring = {
      width = 4;
      active = {
        gradient = {
          angle = 45;
          from = colors.base0B;
          to = colors.base0E;
          in' = "oklch longer hue";
        };
      };
      inactive = {color = colors.base03;};
      urgent = {colors = colors.base08;};
    };

    shadow = {
      enable = true;
      color = colors.base00;
      softness = 20;
      spread = 3;
      offset = {
        x = 5;
        y = 5;
      };
    };

    insert-hint = {
      enable = true;
      display = {color = colors.base0D;};
    };
  };
}
