{
  imports = [
    ./yazi
    ./niri

    ./cliphist.nix
    ./dms.nix
    # ./anyrun.nix
    # ./hyprlock.nix
    # ./stasis.nix
    # ./swaybg.nix
    # ./swaync.nix
    # ./swayosd.nix
    ./udiskie.nix
    # ./waybar.nix
    ./kitty.nix
    ./termfilechooser.nix
  ];

  services.gnome-keyring.enable = true;

  home = {
    sessionVariables = {
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
    persistence."/persist" = {
      directories = [".local/share/keyrings"];
    };
  };

  xdg = {
    mime.enable = true;
  };
}
