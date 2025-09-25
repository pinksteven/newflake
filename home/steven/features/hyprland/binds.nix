{
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$shiftMod" = "SUPER_SHIFT";
    "$ctrl" = "CONTROL_L";
    bind =
      [
        "$mod, grave, exec, uwsm app -- ${lib.getExe pkgs.kitty}" # Kitty
        "$shiftMod, grave, exec, uwsm app -- ${lib.getExe pkgs.kitty} --class floatTerm" # Floating Kitty
        "$mod, F, exec, uwsm app -- ${lib.getExe pkgs.kitty} yazi" # File Manager
        "$mod, B, exec, uwsm app -- ${lib.getExe pkgs.firefox}" # Firefox
        "$mod ,XF86AudioPlay, exec, uwsm app -- spotify --enable-features=UseOzonePlatform --ozone-platform=wayland" # Spotify
        "$ctrl ALT_L, Delete, exec, uwsm app -- ${lib.getExe pkgs.hyprlock}" # Lock
        "$mod, SPACE, exec, uwsm app -- ${lib.getExe pkgs.anyrun}" # Launcher

        ",PRINT, exec, uwsm app -- screenshot region" # Screenshot region
        "ALT, PRINT, exec, uwsm app -- screenshot window" # Screenshot window
        "$ctrl, PRINT, exec, uwsm app -- screenshot monitor" # Screenshot monitor

        "$mod, PRINT, exec, uwsm app -- screenshot region satty" # Screenshot region then edit
        "$mod ALT, PRINT, exec, uwsm app -- screenshot window satty" # Screenshot window then edit
        "$mod $ctrl, PRINT, exec, uwsm app -- screenshot monitor satty" # Screenshot monitor then edit

        "ALT, Tab, cyclenext"
        "ALT, Tab, bringactivetotop" # Simulate Alt-Tab behaviour
        "$mod, S, togglesplit," # Change split horizontal/vertical

        "$mod, Q, killactive," # Close window
        ", F11, fullscreen" # Toggle Fullscreen

        "$ctrl, left, movefocus, l" # Move focus left
        "$ctrl, right, movefocus, r" # Move focus Right
        "$ctrl, up, movefocus, u" # Move focus Up
        "$ctrl, down, movefocus, d" # Move focus Down

        "$mod, up, fullscreen, 1" # Toggle Maximize
        "$mod, down, togglefloating" # Toggle floating
        "$mod, right, workspace, r+1" # Move to next workspace
        "$mod, left, workspace, r-1" # Move to previous workspace

        "$mod SHIFT, right, movetoworkspace, r+1" # Move with window to next workspace
        "$mod SHIFT, left, movetoworkspace, r-1" # Move with window to previous workspace

        "$mod $ctrl, right, movetoworkspacesilent, r+1" # Move window to next workspace
        "$mod $ctrl, left, movetoworkspacesilent, r-1" # Move window to previous workspace_swipe_use_r

        "$mod, V, exec, uwsm app -- clipboard" # Custom clipboard script defined in ./cliphist.nix
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i: let
            ws = i + 1;
          in [
            "$mod,code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT,code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        )
        9
      ));

    bindlp = [
      ",XF86AudioMute, exec, uwsm app -- sound-toggle" # Toggle Mute
      ",XF86AudioPlay, exec, uwsm app -- ${lib.getExe pkgs.playerctl} -i kdeconnect play-pause" # Play/Pause Song
      ",XF86AudioNext, exec, uwsm app -- ${lib.getExe pkgs.playerctl} -i kdeconnect next" # Next Song
      ",XF86AudioPrev, exec, uwsm app -- ${lib.getExe pkgs.playerctl} -i kdeconnect previous" # Previous Song
      ",switch:Lid Switch, exec, uwsm app -- ${lib.getExe pkgs.hyprlock}" # Lock when closing Lid
    ];

    bindlep = [
      ",XF86AudioRaiseVolume, exec, uwsm app -- ${lib.getExe pkgs.hyprpanel} vol +2" # Sound Up
      ",XF86AudioLowerVolume, exec, uwsm app -- ${lib.getExe pkgs.hyprpanel} vol -2" # Sound Down
    ];

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
