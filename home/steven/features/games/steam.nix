{
  pkgs,
  lib,
  ...
}: {
  # Steam is basically installed already
  home.persistence = {
    "/persist/home/steven".directories = [
      ".local/share/Steam"
      ".local/share/icons/hicolor" # Steam holds it's icons here
    ];
  };

  home.packages = [pkgs.deadlock-mod-manager];
  startupPrograms = [
    {
      delay = 1;
      command = ["steam" "-silent"];
    }
  ];
}
