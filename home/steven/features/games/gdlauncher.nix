{pkgs, ...}: {
  home.packages = [pkgs.gdlauncher-carbon];

  home.persistence."/persist/home/steven" = {
    directories = [".local/share/gdlauncher_carbon"];
  };
}
