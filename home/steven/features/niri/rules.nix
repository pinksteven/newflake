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

  hasPortraitMonitor = portraitMonitor != null;
in {
  programs.niri.settings = {
    # Workspace definitions and monitor assignments
    workspaces = {
      # Media workspace - always exists, assigned to portrait monitor if available
      "media" =
        {}
        // lib.optionalAttrs hasPortraitMonitor {
          open-on-output = portraitMonitor.name;
        };
    };

    # Global window rules
    window-rules = [
      # Float yazi-xdg file picker
      {
        matches = [{app-id = "^yazi-xdg$";}];
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
    ];
  };
}
