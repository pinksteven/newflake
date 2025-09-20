{
  pkgs,
  inputs,
  config,
  ...
}: {
  home.persistence."/persist" = {
    directories = [
      ".config/spotify" # User data, saved credentials and so on
      ".cache/spotify/Storage" # Downloaded music for offline
    ];
  };

  stylix.targets.spicetify.enable = false;
  imports = [inputs.spicetify.homeManagerModules.default];

  programs.spicetify = let
    spice = inputs.spicetify.legacyPackages.${pkgs.system};
  in {
    enable = true;
    experimentalFeatures = true;
    wayland = true;
    windowManagerPatch = true;
    theme = spice.themes.hazy;

    # colorScheme = "Violet";

    customColorScheme = with config.lib.stylix.colors; {
      text = base05;
      subtext = base04;
      main = base01;
      main-elevated = base02;
      main-transition = base01;
      highlight = base07;
      highlight-elevated = base0D;
      sidebar = base00;
      player = base01;
      card = base07;
      shadow = base07;
      selected-row = base05;
      button = base0E;
      button-active = base0E;
      button-disabled = base03;
      tab-active = base07;
      notification = base0C;
      notification-error = base08;
      misc = base05;
      play-button = base0D;
      play-button-active = base0D;
      progress-fg = base0D;
      progress-bg = base02;
      heart = base08;
      pagelink-active = base0A;
      radio-btn-active = base0C;
    };

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
}
