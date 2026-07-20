{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    (heroic.override {
      extraPkgs = pkgs':
        with pkgs'; [
          gamescope
          gamemode
        ];
    })
  ];

  home.persistence."/persist" = {
    # Persisit entire heroic dir (can't be bothered to seperate cache)
    directories = [".config/heroic"];
  };

  startupPrograms = [
    {
      delay = 2;
      command = ["${lib.getExe pkgs.heroic}"];
    }
  ];
}
