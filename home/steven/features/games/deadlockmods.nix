{pkgs, ...}: {
  home = {
    packages = [pkgs.deadlock-mod-manager];
    persistance = [
      ".local/share/deadlock-mod-manager"
      ".local/share/dev.stormix.deadlock-mod-manager"
    ];
  };
}
