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
      ".local/share/applications" # .desktop files from installed games
      ".renpy" # Renpy game saves
      ".paradoxlauncher" #bc paradox is special
      ".local/share/Paradox Interactive" #Paradox is very special...
    ];
  };
}
