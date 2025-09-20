{inputs, ...}: {
  imports = [
    ./global

    ./features/stylix
    ./features/hyprland
    ./features/base-apps
    ./features/games
    ./features/dnd
  ];

  wallpaper = "${inputs.wallpapers}/" + "dandadan_yes.jpg";
}
