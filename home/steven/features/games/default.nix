{osConfig, ...}: {
  imports =
    if !osConfig.gamingReady
    then throw "Games feature requires the system to import common/optional/gaming"
    else [
      ./gdlauncher.nix
      ./prism.nix
      ./heroic.nix
      ./steam.nix
    ];

  home.persistence."/persist" = {
    directories = [
      ".config/unity3d" # Unity game saves apparently
      ".local/share/applications" # .desktop files from installed games
      ".renpy" # Renpy game saves
      ".paradoxlauncher" #bc paradox is special
      ".local/share/Paradox Interactive" #Paradox is very special...
    ];
  };
}
