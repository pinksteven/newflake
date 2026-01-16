{pkgs, ...}: {
  home.packages = [pkgs.gdlauncher-carbon];

  home.persistence."/persist" = {
    directories = [".local/share/gdlauncher_carbon"];
  };
}
