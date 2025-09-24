{
  # Steam is basically installed already
  home.persistence = {
    "/persist/home/steven".directories = [
      ".local/share/Steam"
    ];
  };

  wayland.windowManager.hyprland.settings.exec-once = ["uwsm app -- steam -silent"];
}
