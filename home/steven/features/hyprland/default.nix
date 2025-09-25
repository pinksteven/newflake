{
  config,
  monitors,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./binds.nix
    ./cliphist.nix
    # ./dynamic-cursor.nix #Borked??
    ./hypridle.nix
    ./hyprlock.nix
    ./kitty.nix
    ./looks.nix
    ./panel.nix
    ./rules.nix
    ./runner.nix
    ./startup.nix
    ./udiskie.nix
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-termfilechooser
    ];
    config.hyprland.default = lib.mkDefault ["gtk" "hyprland"];
  };

  services.hyprpaper.enable = true;
  home = {
    packages = with pkgs; [playerctl];
    pointerCursor.hyprcursor.enable = true;
  };
  # I want to manage hyprland colors myself
  stylix.targets.hyprland.enable = false;
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = ["--all"]; # From wiki, fixes systemd services launching programs

    settings = {
      xwayland.force_zero_scaling = true;

      general = {
        resize_on_border = true;
        extend_border_grab_area = 15;
        layout = "dwindle";
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        smart_split = true;
      };
      input = {
        kb_layout = "pl";

        repeat_delay = 300;
        repeat_rate = 50;
        follow_mouse = 1;

        touchpad = {
          disable_while_typing = false;
          natural_scroll = true;
          tap-to-click = true;
          tap-and-drag = true;
        };
      };
      gestures.workspace_swipe_use_r = true;
      gesture = ["3, horizontal, workspace"];
      misc = {
        disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background.
        disable_splash_rendering = true;
        disable_autoreload = true;
        new_window_takes_over_fullscreen = 2;
      };
      cursor = {
        no_warps = false;
        inactive_timeout = 60;
        enable_hyprcursor = true;
      };
      ecosystem.no_donation_nag = true;
      render.new_render_scheduling = true;

      monitor = let
        toHyprMonitor = m:
          if m.enabled
          then
            lib.concatStrings ([
                "${m.name}"
                ", ${toString m.width}x${toString m.height}@${toString m.refreshRate}"
                ", ${m.position}"
                ", ${toString m.scale}"
                ", transform, ${toString m.transform}"
                ", cm, auto"
              ]
              ++ lib.optional m.vrr ", vrr, 1")
          else "${m.name}, disabled";
      in
        map toHyprMonitor monitors;

      workspace = lib.concatMap (
        m:
          lib.imap1 (i: ws: "${toString ws}, monitor:${m.name}, persistent:${
              if i < 6
              then "true"
              else "false"
            }, default:${
              if i == 1
              then "true"
              else "false"
            }")
          m.workspace
      ) (lib.filter (m: m.enabled && m.workspace != null) monitors);
    };
  };

  home.sessionVariables = {
    TERMINAL = "${lib.getExe pkgs.kitty}";
    NIXOS_OZONE_WL = 1;

    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    MOZ_ENABLE_WAYLAND = 1;
    ANKI_WAYLAND = 1;
    DISABLE_QT5_COMPAT = 0;

    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;

    WLR_DRM_NO_ATOMIC = 1;
    WLR_BACKEND = "vulkan";
    WLR_RENDERER = "vulkan";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };

  # Sets UWSM session vars by copying home-manager session vars? i think
  xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
}
