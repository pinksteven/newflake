{
  # Steam is basically installed already
  home.persistence = {
    "/persist/home/steven".directories = [
      ".local/share/Steam"
      ".local/share/icons/hicolor" # Steam holds it's icons here
    ];
  };

  wayland.windowManager.hyprland.settings.exec-once = ["uwsm app -- steam -silent"];
}
