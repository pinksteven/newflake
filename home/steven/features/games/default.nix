{gamingReady, ...}: {
  imports =
    if !gamingReady
    then throw "Games feature requires the system to import common/optional/gaming"
    else [
      ./gdlauncher.nix
      ./heroic.nix
      ./steam.nix
    ];

  home.persistence."/persist/home/steven" = {
    directories = [
      ".config/unity3d" # Unity game saves apparently
    ];
  };
}
