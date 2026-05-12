{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./global

    ./features/stylix
    ./features/desktop
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
  base16-theme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
}
