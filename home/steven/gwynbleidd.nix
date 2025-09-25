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

  home.packages = with pkgs; [piper];

  wallpaper = "${inputs.wallpapers}/" + "more_dandadan.jpeg";
}
