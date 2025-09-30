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

    # Global window rules can be added here
    window-rules = [
      # Add any global window rules here that apply across all applications
    ];
  };
}
