{gamingReady, ...}: {
  imports =
    if !gamingReady
    then throw "Games feature requires the system to import common/optional/gaming"
    else [
      ./gdlauncher.nix
      ./heroic.nix
      ./steam.nix
    ];
}
