{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  home.persistence."/persist/home/steven" = {
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
      name = "spotify";
      command = ["${lib.getExe config.programs.spicetify.spicedSpotify}"];
    }
  ];
}
