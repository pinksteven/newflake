{pkgs, ...}: {
  home = {
    packages = [pkgs.deadlock-mod-manager];
    persistence."/persist" = {
      directories = [
        ".local/share/deadlock-mod-manager"
        ".local/share/dev.stormix.deadlock-mod-manager"
      ];
    };
  };
}
