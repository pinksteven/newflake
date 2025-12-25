{
  lib,
  monitors,
  ...
}: let
  # Find first non-primary portrait monitor
  portraitMonitor =
    lib.findFirst
    (m: !(m.primary or false) && ((m.transform.rotation or 0) == 90 || (m.transform.rotation or 0) == 270))
    null
    monitors;
in {
  xdg.configFile."niri/rules.kdl".text = ''
    //Global rules
    window-rule {
      geometry-corner-radius 12
      clip-to-geometry true
    }

    // Floating windows
    window-rule {
      match app-id="^yazi.xdg$"
      match app-id="^org.pulseaudio.pavucontrol$"
      match title="[Pp]icture.in.[Pp]icture"
      match title="[Oo]pen"
      match title="[Ss]ave [Aa]s"
      match title="[Ll]ogin"
      match title="[Aa]uth"
      match app-id="^firefox$" title="Downloads"
      match app-id="^firefox$" title="Bookmarks"
      match app-id="^firefox$" title="History"
      match app-id="^firefox$" title="Extension"

      open-floating true
    }

    // Steam settings
    window-rule {
      match app-id="^steam$"
      exclude title="^Steam$"
      open-floating true
    }
    window-rule {
        match app-id="steam" title=r#"^notificationtoasts_\d+_desktop$"#
        default-floating-position x=0 y=0 relative-to="bottom-right"
        open-focused false
    }

    // VRR settings
    window-rule {
      match app-id="^gamescope$"
      match app-id="exe$"
      match app-id="^[Mm]inecraft"
      match app-id="^steam_app"

      variable-refresh-rate true
    }

    // Vesktop settings
    window-rule {
      match app-id="^vesktop$"
      open-on-workspace "media"
      open-focused false
      default-column-width { proportion ${
      if (portraitMonitor != null)
      then "1.0"
      else "0.6667"
    }; }
      default-window-height { proportion ${
      if (portraitMonitor != null)
      then "0.6667"
      else "1.0"
    }; }
    }

    // Spotify settings
    window-rule {
      match app-id="^spotify$"
      open-on-workspace "media"
      open-focused false
      default-column-width { proportion ${
      if (portraitMonitor != null)
      then "1.0"
      else "0.3333"
    }; }
      default-window-height { proportion ${
      if (portraitMonitor != null)
      then "0.3333"
      else "1.0"
    }; }
    }
  '';
}
