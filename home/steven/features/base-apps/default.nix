{pkgs, ...}: {
  imports = [
    ./easyeffects.nix
    ./firefox.nix
    ./imv.nix
    ./kde-connect.nix
    ./nixcord.nix
    ./spicetify.nix
    ./syncthing.nix
    ./trayscale.nix
    ./zen-broser.nix
  ];

  home.packages = with pkgs; [
    libreoffice-fresh
    hunspell
    hunspellDicts.pl_PL
    clapper
    papers
    overskride
    pavucontrol
    fluffychat #TODO: figure out what files to persist
    teams-for-linux # Thanks uni
  ];
}
