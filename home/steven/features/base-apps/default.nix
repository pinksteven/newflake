{pkgs, ...}: {
  imports = [
    ./easyeffects.nix
    ./firefox.nix
    ./kde-connect.nix
    ./nixcord.nix
    ./obsidian.nix
    ./spicetify.nix
    ./syncthing.nix
  ];

  home.packages = with pkgs; [
    libreoffice-fresh
    hunspell
    hunspellDicts.pl_PL
    clapper
    overskride
    pavucontrol
    fluffychat #TODO: figure out what files to persist
    teams-for-linux # Thanks uni
    ltspice
    kdePackages.gwenview
    kdePackages.okular
  ];
  home.persistence."/persist" = {
    directories = [
      ".local/share/ltspice"
      ".config/libreoffice"
    ];
  };
  xdg.mimeApps.defaultApplications = {"application/pdf" = "okular.desktop";};
}
