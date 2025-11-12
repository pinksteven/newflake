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

  primaryMonitor = lib.head (lib.filter (m: m.primary) monitors);
in {
  programs.niri.settings = {
    spawn-at-startup = [{sh = "niri msg action focus-workspace \"primary\"";}];
    # Workspace definitions and monitor assignments
    workspaces = {
      # Make the primary monitor open an empty workspace
      # On my laptop it opened media workspace automatically and I don't want that
      "primary" = {
        open-on-output = primaryMonitor.name;
      };

      # Media workspace - always exists, assigned to portrait monitor if available
      "media" =
        {}
        // lib.optionalAttrs (portraitMonitor != null) {
          open-on-output = portraitMonitor.name;
        };
    };

    # Global window rules
    window-rules = [
      {
        geometry-corner-radius = {
          top-left = 12.;
          top-right = 12.;
          bottom-left = 12.;
          bottom-right = 12.;
        };
        clip-to-geometry = true;
      }

      # Vesktop - open on media workspace
      {
        matches = [
          {
            app-id = "^vesktop$";
          }
        ];
        open-on-workspace = "media";
        open-focused = false;
        default-column-width = {
          proportion =
            if (portraitMonitor != null)
            then 1.
            else 2. / 3.;
        };
        default-window-height = {
          proportion =
            if (portraitMonitor != null)
            then 2. / 3.
            else 1.;
        };
      }

      # Spotify - open on media workspace
      {
        matches = [
          {
            app-id = "^spotify$";
          }
        ];
        open-on-workspace = "media";
        open-focused = false;
        default-column-width = {
          proportion =
            if (portraitMonitor != null)
            then 1.0
            else 1. / 3.;
        };
        default-window-height = {
          proportion =
            if (portraitMonitor != null)
            then 1. / 3.
            else 1.;
        };
      }

      # Float yazi-xdg file picker
      {
        matches = [{app-id = "^yazi.xdg$";}];
        open-floating = true;
      }

      # Float pavucontrol (volume control)
      {
        matches = [{app-id = "^org.pulseaudio.pavucontrol$";}];
        open-floating = true;
      }

      # Float Firefox picture-in-picture
      {
        matches = [
          {
            app-id = "^firefox$";
            title = "^.*[Pp]icture.in.[Pp]icture.*$";
          }
        ];
        open-floating = true;
      }

      # Float LibreOffice dialogs
      {
        matches = [{title = "^.*[Oo]pen.*$";}];
        open-floating = true;
      }
      {
        matches = [{title = "^.*[Ss]ave [Aa]s.*$";}];
        open-floating = true;
      }

      # Float authentication dialogs
      {
        matches = [{title = "^.*[Ll]ogin.*$";}];
        open-floating = true;
      }
      {
        matches = [{title = "^.*[Aa]uth.*$";}];
        open-floating = true;
      }

      # Float Firefox dialogs and popups
      {
        matches = [
          {
            app-id = "^firefox$";
            title = "^.*Downloads.*$";
          }
        ];
        open-floating = true;
      }
      {
        matches = [
          {
            app-id = "^firefox$";
            title = "^.*Bookmarks.*$";
          }
        ];
        open-floating = true;
      }
      {
        matches = [
          {
            app-id = "^firefox$";
            title = "^.*History.*$";
          }
        ];
        open-floating = true;
      }
      {
        matches = [
          {
            app-id = "^firefox$";
            title = "^.*Extension.*$";
          }
        ];
        open-floating = true;
      }
      # Steam notification "fix"
      {
        matches = [
          {
            app-id = "steam";
            title = "^.*notificationtoasts.*$";
          }
        ];
        default-floating-position = {
          relative-to = "bottom-right";
          x = 10;
          y = 10;
        };
      }
      # Float Steam dialogs
      {
        matches = [
          {
            app-id = "steam";
          }
        ];
        excludes = [
          {
            title = "^Steam$";
          }
        ];
        open-floating = true;
      }
    ];
  };
}
