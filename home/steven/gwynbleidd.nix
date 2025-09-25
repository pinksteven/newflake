{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./global

    ./features/stylix
    ./features/hyprland
    ./features/base-apps
    ./features/games
    ./features/dnd
  ];

  home = {
    packages = with pkgs; [piper];
    sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };

  wallpaper = "${inputs.wallpapers}/" + "more_dandadan.jpeg";
}
