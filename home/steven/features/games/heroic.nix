{pkgs, ...}: {
  home.packages = [pkgs.heroic];

  home.persistence."/persist/home/steven" = {
    # Persisit entire heroic dir (can't be bothered to seperate cache)
    directories = [".config/heroic"];
  };

  # Remember to enable "Start Minimized" in heroic settings (can't do it any other way)
  wayland.windowManager.hyprland.settings.exec-once = ["uwsm app -- heroic"];
}
