{config, ...}: {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    dms-ipc = spawn "dms" "ipc";
  in {
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

    # DankMaterialShell keybinds
    "Mod+N" = {
      action = dms-ipc "notifications" "toggle";
      hotkey-overlay.title = "Toggle Notification Center";
    };
    "Super+Alt+L" = {
      action = dms-ipc "lock" "lock";
      hotkey-overlay.title = "Toggle Lock Screen";
    };
    "Mod+X" = {
      action = dms-ipc "powermenu" "toggle";
      hotkey-overlay.title = "Toggle Power Menu";
    };
    "XF86AudioRaiseVolume" = {
      allow-when-locked = true;
      action = dms-ipc "audio" "increment" "3";
    };
    "XF86AudioLowerVolume" = {
      allow-when-locked = true;
      action = dms-ipc "audio" "decrement" "3";
    };
    "XF86AudioMute" = {
      allow-when-locked = true;
      action = dms-ipc "audio" "mute";
    };
    "XF86AudioMicMute" = {
      allow-when-locked = true;
      action = dms-ipc "audio" "micmute";
    };
    "XF86AudioPrev" = {
      allow-when-locked = true;
      action = dms-ipc "mpris" "previous";
    };
    "XF86AudioNext" = {
      allow-when-locked = true;
      action = dms-ipc "mpris" "next";
    };
    "XF86AudioPlay" = {
      allow-when-locked = true;
      action = dms-ipc "mpris" "playPause";
    };
    "XF86AudioStop" = {
      allow-when-locked = true;
      action = dms-ipc "mpris" "stop";
    };

    # Anyrun
    "Mod+Space".action = spawn "anyrun";
    "Mod+V".action = spawn "clipboard";
  };
}
