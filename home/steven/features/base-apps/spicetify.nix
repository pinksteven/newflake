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
      ".cache/spotify" # Downloaded music for offline and some shit i don't even know
    ];
  };

  imports = [inputs.spicetify.homeManagerModules.default];

  programs.spicetify = let
    spice = pkgs.inputs.spicetify;
  in {
    enable = true;
    wayland = true;
    windowManagerPatch = true;

    enabledExtensions = with spice.extensions; [
      autoSkipVideo
      keyboardShortcut
      aiBandBlocker
      spicyLyrics
      fullAlbumDate
      copyToClipboard
      betterGenres
      hidePodcasts
      playNext
    ];

    enabledSnippets = with spice.snippets; [
      fixDjIcon
      fixLikedIcon
      hideFriendActivityButton
      hideWhatsNewButton
      # hideLyricsButton
      removePopular
    ];

    # # Uncomment for looking through marketplace
    # enabledCustomApps = with spice.apps; [
    #   marketplace
    # ];
  };

  startupPrograms = [
    {
      delay = 5;
      command = ["${lib.getExe config.programs.spicetify.spicedSpotify}"];
    }
  ];
}
