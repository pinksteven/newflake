{pkgs, ...}: {
  home = {
    packages = [pkgs.deadlock-mod-manager];
    persistence."/persist/home/steven".directoriest = [
      ".local/share/deadlock-mod-manager"
      ".local/share/dev.stormix.deadlock-mod-manager"
    ];
  };
}
