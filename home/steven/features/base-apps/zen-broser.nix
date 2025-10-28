{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.beta];

  stylix.targets.zen-browser.profileNames = ["default"];

  programs.zen-browser = {
    enable = true;

    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };

    profiles.default = {
      isDefault = true;
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        privacy-badger
        return-youtube-dislikes
        sponsorblock
        istilldontcareaboutcookies
      ];
    };
  };

  xdg.mimeApps = let
    value = let
      zen-browser = pkgs.inputs.zen-browser.beta; # or twilight
    in
      zen-browser.meta.desktopFileName;

    associations = builtins.listToAttrs (map (name: {
        inherit name value;
      }) [
        "application/x-extension-shtml"
        "application/x-extension-xhtml"
        "application/x-extension-html"
        "application/x-extension-xht"
        "application/x-extension-htm"
        "x-scheme-handler/unknown"
        "x-scheme-handler/mailto"
        "x-scheme-handler/chrome"
        "x-scheme-handler/about"
        "x-scheme-handler/https"
        "x-scheme-handler/http"
        "application/xhtml+xml"
        "application/json"
        "text/plain"
        "text/html"
      ]);
  in {
    associations.added = associations;
    defaultApplications = associations;
  };
}
