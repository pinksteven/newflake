{
  pkgs,
  lib,
  ...
}: {
  # Steam is basically installed already
  home.persistence = {
    "/persist".directories = [
      ".local/share/Steam"
      ".local/share/icons/hicolor" # Steam holds it's icons here
    ];
  };

  startupPrograms = [
    {
      delay = 1;
      command = ["steam" "-silent"];
    }
  ];
}
