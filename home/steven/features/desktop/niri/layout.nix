{config, ...}: let
  colors = config.lib.stylix.colors.withHashtag;
in {
  xdg.configFile."niri/layout.kdl".text = ''
    layout {
      gaps 10
      always-center-single-column

      preset-column-widths {
        proportion 0.3333
        proportion 0.5
        proportion 0.6667
      }
      default-column-width { proportion 0.5; }
      preset-column-widths {
        proportion 0.3333
        proportion 0.5
        proportion 0.6667
      }

      focus-ring {
        on
        width 4
        active-gradient from="${colors.base0B}" to="${colors.base0E}" angle=45 in="oklch longer hue"
        inactive-color "${colors.base03}"
        urgent-color "${colors.base08}"
      }
      shadow {
        on
        color "${colors.base00}"
        softness 20
        spread 3
        offset x=5 y=5
      }
      insert-hint {
        on
        color "${colors.base0D}"
      }
  '';
}
