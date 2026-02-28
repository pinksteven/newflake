{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  home.persistence."/persist" = {
    directories = [
      ".config/spotify" # User data, saved credentials and so on
      ".cache/spotify/Storage" # Downloaded music for offline
    ];
  };

  imports = [inputs.spicetify.homeManagerModules.default];

  programs.spicetify = let
    spice = pkgs.inputs.spicetify;
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
  };

  startupPrograms = [
    {
      delay = 5;
      command = ["${lib.getExe config.programs.spicetify.spicedSpotify}"];
    }
  ];
}
