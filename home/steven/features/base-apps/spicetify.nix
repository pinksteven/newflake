{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  hasNiri = lib.attrByPath ["programs" "niri" "enable"] false config;
in {
  home.persistence."/persist/home/steven" = {
    directories = [
      ".config/spotify" # User data, saved credentials and so on
      ".cache/spotify/Storage" # Downloaded music for offline
    ];
  };

  imports = [inputs.spicetify.homeManagerModules.default];

  programs.spicetify = let
    spice = inputs.spicetify.legacyPackages.${pkgs.system};
  in {
    enable = true;
    experimentalFeatures = true;
    wayland = true;
    windowManagerPatch = true;

    enabledExtensions = with spice.extensions; [
      fullAppDisplay
      keyboardShortcut
      shuffle

      playlistIcons
      fullAlbumDate
      copyToClipboard
      history
      betterGenres
      lastfm
      hidePodcasts
      playNext
    ];
    enabledCustomApps = with spice.apps; [
      newReleases
    ];
  };

  startupPrograms = [
    {
      name = "spotify";
      command = ["${lib.getExe config.programs.spicetify.spicedSpotify}"];
    }
  ];
}
