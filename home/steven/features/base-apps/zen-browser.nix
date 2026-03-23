{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.beta];
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    languagePacks = ["en_US" "pl"];

    policies = {
      SkipTermsOfUse = true;
      AutofillAddressEnabled = true;
      # AutofillCreditCardEnabled = false; Does gopass support creditcard info???
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      # OfferToSaveLogins = false; Maybe later
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DefaultDownloadDirectory = "\${home}/Downloads";
    };

    profiles.steven = {
      isDefault = true;
      settings = {
        "browser.tabs.closeWindowWithLastTab" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "media.rdd-ffmpeg.enabled" = lib.mkIf (config.home.sessionVariables.LIBVA_DRIVER_NAME == "nvidia") true;
        "gfx.x11-egl.force-enabled" = lib.mkIf (config.home.sessionVariables.LIBVA_DRIVER_NAME == "nvidia") true;
        # Auto enable extensions
        "extensions.autoDisableScopes" = 0;
      };
      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          return-youtube-dislikes
          sponsorblock
          istilldontcareaboutcookies
          qwant-search
        ];
      };
      search = {
        force = true;
        default = "qwant";
        privateDefault = "qwant";
        engines = {
          nix-packages = {
            name = "Nix Packages";
            urls = [
              {template = "https://searchix.alanpearce.eu/packages/nixpkgs/search?query={searchTerms}";}
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };
          homemanager = {
            name = "Home Manager Options";
            urls = [
              {template = "https://searchix.alanpearce.eu/options/home-manager/search?query={searchTerms}";}
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@hm"];
          };
          nix-options = {
            name = "NixOS Options";
            urls = [
              {template = "https://searchix.alanpearce.eu/options/nixos/search?query={searchTerms}";}
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@no"];
          };
          nur-packages = {
            name = "NUR Packages";
            urls = [
              {template = "https://searchix.alanpearce.eu/packages/nur/search?query={searchTerms}";}
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nur"];
          };

          bing.metaData.hidden = true;
        };
      };
    };
  };

  stylix.targets.zen-browser = {
    enable = true;
    profileNames = ["steven"];
  };
  home.persistence."/persist" = {
    directories = [".config/zen"];
  };
}
