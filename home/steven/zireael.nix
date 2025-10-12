{inputs, ...}: {
  imports = [
    ./global

    ./features/stylix
    ./features/desktop/niri
    ./features/base-apps
    ./features/games
    ./features/dnd
    ./features/zed
  ];

  home = {
    sessionVariables = {
      LIBVA_DRIVER_NAME = "radeonsi";
      VDPAU_DRIVER = "radeonsi";
    };
  };

  wallpaper = "${inputs.wallpapers}/" + "girl.jpg";
}
