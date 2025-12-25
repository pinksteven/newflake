{
  xdg.configFile."niri/binds.kdl".text = ''
    binds {
        Alt+Mod+Left { focus-monitor-left; }
        Alt+Mod+Right { focus-monitor-right; }
        Alt+Tab { switch-focus-between-floating-and-tiling; }
        "Caps_Lock" allow-when-locked=true { spawn-sh "swayosd-client --capslock"; }
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
        Mod+N hotkey-overlay-title="Toggle Notification Center" { spawn "swaync-client" "-t" "-sw"; }
        "Mod+Page_Down" { focus-workspace-down; }
        "Mod+Page_Up" { focus-workspace-up; }
        Mod+Q { close-window; }
        Mod+R { switch-preset-column-width; }
        Mod+Right { focus-column-right; }
        Mod+Shift+M { focus-workspace "media"; }
        "Mod+Shift+Page_Down" { move-column-to-workspace-down; }
        "Mod+Shift+Page_Up" { move-column-to-workspace-up; }
        Mod+Shift+slash { show-hotkey-overlay; }
        Mod+Space { spawn "anyrun"; }
        Mod+T { toggle-window-floating; }
        Mod+Tab { toggle-overview; }
        Mod+Up { focus-window-up; }
        Mod+V { spawn "clipboard"; }
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
        Super+Alt+L hotkey-overlay-title="Toggle Lock Screen" { spawn "hyprlock"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn-sh "swayosd-client --output-volume=-2"; }
        XF86AudioMicMute allow-when-locked=true { spawn-sh "swayosd-client --input-volume=mute-toggle"; }
        XF86AudioMute allow-when-locked=true { spawn-sh "swayosd-client --output-volume=mute-toggle"; }
        XF86AudioNext allow-when-locked=true { spawn-sh "swayosd-client --playerctl=next"; }
        XF86AudioPlay allow-when-locked=true { spawn-sh "swayosd-client --playerctl=play-pause"; }
        XF86AudioPrev allow-when-locked=true { spawn-sh "swayosd-client --playerctl=previous"; }
        XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "swayosd-client --output-volume=+2"; }
        XF86AudioStop allow-when-locked=true { spawn-sh "swayosd-client --playerctl=stop"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn-sh "swayosd-client --brightness=lower"; }
        XF86MonBrightnessUp allow-when-locked=true { spawn-sh "swayosd-client --brightness=raise"; }
    }
  '';
}
