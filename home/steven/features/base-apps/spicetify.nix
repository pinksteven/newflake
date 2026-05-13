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
      hideLyricsButton
      removePopular
    ];

    enabledCustomApps = with spice.apps; [
      marketplace
      historyInSidebar
      {
        # The source of the customApp
        # make sure you're using the correct branch
        # It could also be a sub-directory of the repo
        src = pkgs.fetchFromGitHub {
          owner = "Xndr2";
          repo = "listening-stats";
          rev = "v2.0.0";
          hash = "sha256-6EKv1HwYlkyA/fZ6orBNLeUh8vLWnGNwrpak+S8W700=";
        };
        name = "listening-stats";
      }
    ];
  };

  startupPrograms = [
    {
      delay = 5;
      command = ["${lib.getExe config.programs.spicetify.spicedSpotify}"];
    }
  ];
}
