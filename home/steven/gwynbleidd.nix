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
    ./features/zed
  ];

  home = {
    packages = with pkgs; [piper];
    sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      MOZ_DISABLE_RDD_SANDBOX = 1;
    };
  };

  wallpaper = "${inputs.wallpapers}/" + "more_dandadan.jpeg";
}
