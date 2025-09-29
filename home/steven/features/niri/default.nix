{
  inputs,
  pkgs,
  lib,
  monitors,
  ...
}: {
  imports = [
    inputs.niri-flake.homeModules.niri
    inputs.niri-flake.homeModules.stylix

    ./animations.nix
    ./binds.nix
    ./cliphist.nix
    ./ghostty.nix
    ./layout.nix
    ./rules.nix
    ./udiskie.nix
  ];

  xdg = {
    autostart.enable = true;
    mime.enable = true;
  };

  services.gnome-keyring.enable = lib.mkForce false;

  programs.niri = {
    enable = true;
    package = pkgs.niri-stable;

    settings = {
      input = {
        focus-follows-mouse.enable = true;
        power-key-handling.enable = false; # Use logind option in nixos to set this per device basis
        keyboard = {
          numlock = true; # None of my devices have numpad replacing other keys
          xkb.layout = "pl";
          repeat-delay = 300;
          repeat-rate = 50;
        };
        mouse = {
          enable = true;
          accel-profile = "flat";
        };
        touchpad = {
          enable = true;
          accel-profile = "adaptive";
          click-method = "button-areas";
          scroll-method = "two-fingers";
          tap = true;
          tap-button-map = "left-right-middle";
          natural-scroll = true;
          drag = true;
        };
      };
      outputs = builtins.listToAttrs (map (m: {
          name = m.name;
          value = {
            enable = m.enabled;
            mode = {
              inherit (m) width height;
              refresh = m.refreshRate;
            };
            focus-at-startup = m.primary;
            variable-refresh-rate = m.vrr;
            inherit (m) scale position transform;
          };
        })
        monitors);
      screenshot-path = "~/Pictures/Screenshots/Screenshot_%Y-%m-%d_%H:%M:%S.png";
    };
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;

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
}
