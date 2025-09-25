{
  pkgs,
  lib,
  ...
}: let
  ws-cycle = pkgs.writeShellScriptBin "ws-cycle" ''
    command="$1"
    direction="$2"

    if [[ "$command" == "go" ]]; then
      CMD="workspace"
    elif [[ "$command" == "move" ]]; then
      CMD="movetoworkspace"
    else
      echo "Usage: $0 go|move next|prev"
      exit 1
    fi

    CURRENT_MONITOR=$(hyprctl activeworkspace -j | jq -r '.monitor')
    CURRENT_WS=$(hyprctl activeworkspace -j | jq -r '.id')

    WS_LIST=$(hyprctl workspacerules -j | jq -r ".[] | select(.monitor==\"$CURRENT_MONITOR\") | .workspaceString")
    WS_LIST=($(printf "%s\n" "''${WS_LIST[@]}" | sort -n))

    FIRST=''${WS_LIST[0]}
    LAST=''${WS_LIST[-1]}

    if [[ "$direction" == "next" ]]; then
      if [[ "$CURRENT_WS" == "$LAST" ]]; then
        hyprctl dispatch $CMD $FIRST
        exit
      else
        hyprctl dispatch $CMD r+1
        exit
      fi
    elif [[ "$direction" == "prev" ]]; then
      if [[ "$CURRENT_WS" == "$FIRST" ]]; then
        hyprctl dispatch $CMD $LAST
        exit
      else
        hyprctl dispatch $CMD r-1
        exit
      fi
    else
      echo "Usage: $0 go|move next|prev"
      exit 1
    fi
  '';
in {
  home.packages = [ws-cycle];
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

        "$mod, right, exec, ws-cycle go next" # Move to next workspace
        "$mod, left, exec, ws-cycle go prev" # Move to previous workspace

        "$mod SHIFT, right, exec, ws-cycle move next" # Move with window to next workspace
        "$mod SHIFT, left, exec, ws-cycle move prev" # Move with window to previous workspace

        "$mod, V, exec, uwsm app -- clipboard" # Custom clipboard script defined in ./cliphist.nix
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i: let
            ws = i + 1;
          in [
            "$mod,code:1${toString i}, workspace, r~${toString ws}"
            "$mod SHIFT,code:1${toString i}, movetoworkspace, r~${toString ws}"
          ]
        )
        10
      ));

    bindlp = [
      ",XF86AudioMute, exec, uwsm app -- sound-toggle" # Toggle Mute
      ",XF86AudioPlay, exec, uwsm app -- ${lib.getExe pkgs.hyprpanel} pp" # Play/Pause Song
      ",XF86AudioNext, exec, uwsm app -- ${lib.getExe pkgs.hyprpanel} pln" # Next Song
      ",XF86AudioPrev, exec, uwsm app -- ${lib.getExe pkgs.hyprpanel} plp" # Previous Song
      "$mod ,XF86AudioNext, exec, uwsm app -- ${lib.getExe pkgs.hyprpanel} mpn" # Next Player
      "$mod ,XF86AudioPrev, exec, uwsm app -- ${lib.getExe pkgs.hyprpanel} mpp" # Previous Player
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
