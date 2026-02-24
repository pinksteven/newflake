{
  xdg.configFile."niri/binds.kdl".text = ''
    binds {
        Alt+Mod+Left { focus-monitor-left; }
        Alt+Mod+Right { focus-monitor-right; }
        Alt+Tab { switch-focus-between-floating-and-tiling; }
        Ctrl+Alt+Delete { quit; }
        Ctrl+Mod+Left { consume-or-expel-window-left; }
        Ctrl+Mod+R { maximize-column; }
        Ctrl+Mod+Right { consume-or-expel-window-right; }
        F11 { fullscreen-window; }
        Mod+B { spawn "firefox"; }
        Mod+Down { focus-window-down; }
        Mod+F { spawn "kitty" "--hold=yes" "yazi"; }
        Mod+grave { spawn "kitty"; }
        Mod+Left { focus-column-left; }
        "Mod+Page_Down" { focus-workspace-down; }
        "Mod+Page_Up" { focus-workspace-up; }
        Mod+Q { close-window; }
        Mod+R { switch-preset-column-width; }
        Mod+Right { focus-column-right; }
        Mod+Shift+M { focus-workspace "media"; }
        "Mod+Shift+Page_Down" { move-column-to-workspace-down; }
        "Mod+Shift+Page_Up" { move-column-to-workspace-up; }
        Mod+Shift+slash { show-hotkey-overlay; }
        Mod+Space { spawn-sh "dms ipc call spotlight toggle"; }
        Mod+T { toggle-window-floating; }
        Mod+Tab { toggle-overview; }
        Mod+Up { focus-window-up; }
        Mod+V { spawn-sh "dms ipc call clipboard toggle"; }
        Mod+WheelScrollDown { focus-column-right; }
        Mod+WheelScrollUp { focus-column-left; }
        Mod+equal { set-column-width "+5%"; }
        Mod+minus { set-column-width "-5%"; }
        Print { spawn-sh "niri msg action screenshot"; }
        Shift+Mod+Down { move-window-down; }
        Shift+Mod+Left { move-column-left; }
        Shift+Mod+R { switch-preset-column-width-back; }
        Shift+Mod+Right { move-column-right; }
        Shift+Mod+Up { move-window-up; }
        Shift+Mod+equal { set-window-height "+5%"; }
        Shift+Mod+minus { set-window-height "-5%"; }
        Shift+Print { spawn-sh "niri msg action screenshot-window"; }
        Super+Alt+L hotkey-overlay-title="Toggle Lock Screen" { spawn-sh "dms ipc call lock lock"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn-sh "dms ipc call audio decrement 2"; }
        XF86AudioMicMute allow-when-locked=true { spawn-sh "dms ipc call audio micmute"; }
        XF86AudioMute allow-when-locked=true { spawn-sh "dms ipc call audio mute"; }
        XF86AudioNext allow-when-locked=true { spawn-sh "dms ipc call mpris next"; }
        XF86AudioPlay allow-when-locked=true { spawn-sh "dms ipc call mpris playPause"; }
        XF86AudioPrev allow-when-locked=true { spawn-sh "dms ipc call mpris previous"; }
        XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "dms ipc call audio increment 2"; }
        XF86AudioStop allow-when-locked=true { spawn-sh "dms ipc call mpris stop"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn-sh "dms ipc call brightness decrement 5 \"\""; }
        XF86MonBrightnessUp allow-when-locked=true { spawn-sh "dms ipc call brightness increment 5 \"\""; }

        Ctrl+Shift+M { spawn-sh "equibop --toggle-mic"; }
        Menu { spawn-sh "equibop --toggle-mic"; }
    }
  '';
}
