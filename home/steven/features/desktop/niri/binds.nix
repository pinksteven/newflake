{config, ...}: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Ctrl+Alt+Delete".action = quit;
    "Mod+F".action = spawn "ghostty" "-e" "yazi";
    "Mod+B".action = spawn "firefox";
    "Mod+Q".action = close-window;

    # Window navigation with arrow keys
    "Mod+Left".action = focus-column-left;
    "Mod+Right".action = focus-column-right;
    "Mod+Up".action = focus-window-up;
    "Mod+Down".action = focus-window-down;

    # Move windows with Shift+Mod+arrow keys
    "Shift+Mod+Left".action = move-column-left;
    "Shift+Mod+Right".action = move-column-right;
    "Shift+Mod+Up".action = move-window-up;
    "Shift+Mod+Down".action = move-window-down;
    # Workspace navigation
    "Mod+Page_Up".action = focus-workspace-up;
    "Mod+Page_Down".action = focus-workspace-down;

    # Access media workspace (Spotify + Vesktop)
    "Mod+Shift+M".action = focus-workspace "media";

    # Column navigation with scroll wheel
    "Mod+WheelScrollUp".action = focus-column-left;
    "Mod+WheelScrollDown".action = focus-column-right;
  };
}
