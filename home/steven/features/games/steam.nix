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

  startupPrograms = [
    {
      name = "steam";
      command = ["steam" "-silent"];
    }
  ];
}
