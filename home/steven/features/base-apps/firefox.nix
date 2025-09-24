{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    languagePacks = ["en_US" "pl"];
    policies = {
      SkipTermsOfUse = true;
      BlockAboutConfig = true;
      DefaultDownloadDirectory = "\${home}/Downloads";
    };

    profiles.steven = {
      isDefault = true;
      settings = {
        "browser.tabs.closeWindowWithLastTab" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "widget.use-xdg-desktop-portal.file-picker" = 1;

        # Disable irritating first-run stuff
        "browser.disableResetPrompt" = true;
        "browser.aboutwelcome.enabled" = false;
        "browser.download.panel.shown" = true;
        "browser.feeds.showFirstRunUI" = false;
        "browser.messaging-system.whatsNewPanel.enabled" = false;
        "browser.rights.3.shown" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.uitour.enabled" = false;
        "startup.homepage_override_url" = "";
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.bookmarks.addedImportButton" = true;

        # Disable some telemetry
        "app.shield.optoutstudies.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.clean" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;

        # Layout
        "browser.uiCustomization.state" = builtins.toJSON {
          currentVersion = 23;
          newElementCount = 3;
          dirtyAreaCache = ["nav-bar" "vertical-tabs" "PersonalToolbar" "unified-extensions-area" "TabsToolbar" "toolbar-menubar"];
          placements = {
            PersonalToolbar = ["personal-bookmarks"];
            vertical-tabs = ["tabbrowser-tabs"];
            TabsToolbar = [];
            nav-bar = [
              "sidebar-button"
              "back-button"
              "stop-reload-button"
              "forward-button"
              "customizableui-special-spring1"
              "vertical-spacer"
              "urlbar-container"
              "customizableui-special-spring2"
              "downloads-button"
              "fxa-toolbar-menu-button"
              "unified-extensions-button"
              "ublock0_raymondhill_net-browser-action"
            ];
            toolbar-menubar = ["menubar-items"];
            unified-extensions-area = ["firefoxcolor_mozilla_com-browser-action"];
            widget-overflow-fixed-list = [];
          };
          seen = ["developer-button" "ublock0_raymondhill_net-browser-action" "firefoxcolor_mozilla_com-browser-action"];
        };
      };
      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          privacy-badger
          tabliss
          return-youtube-dislikes
          sponsorblock
          istilldontcareaboutcookies
        ];
      };
      search = {
        force = true;
        default = "startpage";
        privateDefault = "startpage";
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

          startpage = {
            name = "Startpage";
            urls = [{template = "https://www.startpage.com/do/dsearch?q={searchTerms}";}];
            icon = "https://www.startpage.com/sp/cdn/favicons/favicon--default.ico";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [
              "@sp"
              "@startpage"
            ];
          };
          bing.metaData.hidden = true;
        };
      };
      userChrome = ''
        .titlebar-buttonbox-container {
          display: none;
        }
      '';
      # Betterfox config
      extraConfig = ''
        /* You may copy+paste this file and use it as it is.
         *
         * If you make changes to your about:config while the program is running, the
         * changes will be overwritten by the user.js when the application restarts.
         *
         * To make lasting changes to preferences, you will have to edit the user.js.
         */

        /****************************************************************************
         * Betterfox                                                                *
         * "Ad meliora"                                                             *
         * version: 130                                                             *
         * url: https://github.com/yokoffing/Betterfox                              *
        ****************************************************************************/

        /****************************************************************************
         * SECTION: FASTFOX                                                         *
        ****************************************************************************/
        /** GENERAL ***/
        user_pref("content.notify.interval", 100000);

        /** GFX ***/
        user_pref("gfx.canvas.accelerated.cache-items", 4096);
        user_pref("gfx.canvas.accelerated.cache-size", 512);
        user_pref("gfx.content.skia-font-cache-size", 20);

        /** DISK CACHE ***/
        user_pref("browser.cache.jsbc_compression_level", 3);

        /** MEDIA CACHE ***/
        user_pref("media.memory_cache_max_size", 65536);
        user_pref("media.cache_readahead_limit", 7200);
        user_pref("media.cache_resume_threshold", 3600);

        /** IMAGE CACHE ***/
        user_pref("image.mem.decode_bytes_at_a_time", 32768);

        /** NETWORK ***/
        user_pref("network.http.max-connections", 1800);
        user_pref("network.http.max-persistent-connections-per-server", 10);
        user_pref("network.http.max-urgent-start-excessive-connections-per-host", 5);
        user_pref("network.http.pacing.requests.enabled", false);
        user_pref("network.dnsCacheExpiration", 3600);
        user_pref("network.ssl_tokens_cache_capacity", 10240);

        /** SPECULATIVE LOADING ***/
        user_pref("network.dns.disablePrefetch", true);
        user_pref("network.dns.disablePrefetchFromHTTPS", true);
        user_pref("network.prefetch-next", false);
        user_pref("network.predictor.enabled", false);
        user_pref("network.predictor.enable-prefetch", false);

        /** EXPERIMENTAL ***/
        user_pref("dom.enable_web_task_scheduling", true);

        /****************************************************************************
         * SECTION: SECUREFOX                                                       *
        ****************************************************************************/
        /** TRACKING PROTECTION ***/
        user_pref("browser.contentblocking.category", "strict");
        user_pref("urlclassifier.trackingSkipURLs", "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com");
        user_pref("urlclassifier.features.socialtracking.skipURLs", "*.instagram.com, *.twitter.com, *.twimg.com");
        user_pref("network.cookie.sameSite.noneRequiresSecure", true);
        user_pref("browser.download.start_downloads_in_tmp_dir", true);
        user_pref("browser.helperApps.deleteTempFileOnExit", true);
        user_pref("browser.uitour.enabled", false);
        user_pref("privacy.globalprivacycontrol.enabled", true);

        /** OCSP & CERTS / HPKP ***/
        user_pref("security.OCSP.enabled", 0);
        user_pref("security.remote_settings.crlite_filters.enabled", true);
        user_pref("security.pki.crlite_mode", 2);

        /** SSL / TLS ***/
        user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
        user_pref("browser.xul.error_pages.expert_bad_cert", true);
        user_pref("security.tls.enable_0rtt_data", false);

        /** DISK AVOIDANCE ***/
        user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
        user_pref("browser.sessionstore.interval", 60000);

        /** SHUTDOWN & SANITIZING ***/
        user_pref("privacy.history.custom", true);

        /** SEARCH / URL BAR ***/
        user_pref("browser.urlbar.trimHttps", true);
        user_pref("browser.urlbar.untrimOnUserInteraction.featureGate", true);
        user_pref("browser.search.separatePrivateDefault.ui.enabled", true);
        user_pref("browser.urlbar.update2.engineAliasRefresh", true);
        user_pref("browser.search.suggest.enabled", false);
        user_pref("browser.urlbar.quicksuggest.enabled", false);
        user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
        user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
        user_pref("browser.urlbar.groupLabels.enabled", false);
        user_pref("browser.formfill.enable", false);
        user_pref("security.insecure_connection_text.enabled", true);
        user_pref("security.insecure_connection_text.pbmode.enabled", true);
        user_pref("network.IDN_show_punycode", true);

        /** HTTPS-FIRST POLICY ***/
        user_pref("dom.security.https_first", true);

        /** PASSWORDS ***/
        user_pref("signon.formlessCapture.enabled", false);
        user_pref("signon.privateBrowsingCapture.enabled", false);
        user_pref("network.auth.subresource-http-auth-allow", 1);
        user_pref("editor.truncate_user_pastes", false);

        /** MIXED CONTENT + CROSS-SITE ***/
        user_pref("security.mixed_content.block_display_content", true);
        user_pref("pdfjs.enableScripting", false);

        /** EXTENSIONS ***/
        user_pref("extensions.enabledScopes", 5);

        /** HEADERS / REFERRERS ***/
        user_pref("network.http.referer.XOriginTrimmingPolicy", 2);

        /** CONTAINERS ***/
        user_pref("privacy.userContext.ui.enabled", true);

        /** SAFE BROWSING ***/
        user_pref("browser.safebrowsing.downloads.remote.enabled", false);

        /** MOZILLA ***/
        user_pref("permissions.default.desktop-notification", 2);
        user_pref("permissions.default.geo", 2);
        user_pref("permissions.manager.defaultsUrl", "");
        user_pref("webchannel.allowObject.urlWhitelist", "");

        /** TELEMETRY ***/
        user_pref("datareporting.policy.dataSubmissionEnabled", false);
        user_pref("datareporting.healthreport.uploadEnabled", false);
        user_pref("toolkit.telemetry.unified", false);
        user_pref("toolkit.telemetry.enabled", false);
        user_pref("toolkit.telemetry.server", "data:,");
        user_pref("toolkit.telemetry.archive.enabled", false);
        user_pref("toolkit.telemetry.newProfilePing.enabled", false);
        user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
        user_pref("toolkit.telemetry.updatePing.enabled", false);
        user_pref("toolkit.telemetry.bhrPing.enabled", false);
        user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
        user_pref("toolkit.telemetry.coverage.opt-out", true);
        user_pref("toolkit.coverage.opt-out", true);
        user_pref("toolkit.coverage.endpoint.base", "");
        user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
        user_pref("browser.newtabpage.activity-stream.telemetry", false);

        /** EXPERIMENTS ***/
        user_pref("app.shield.optoutstudies.enabled", false);
        user_pref("app.normandy.enabled", false);
        user_pref("app.normandy.api_url", "");

        /** CRASH REPORTS ***/
        user_pref("breakpad.reportURL", "");
        user_pref("browser.tabs.crashReporting.sendReport", false);
        user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);

        /** DETECTION ***/
        user_pref("captivedetect.canonicalURL", "");
        user_pref("network.captive-portal-service.enabled", false);
        user_pref("network.connectivity-service.enabled", false);

        /****************************************************************************
         * SECTION: PESKYFOX                                                        *
        ****************************************************************************/
        /** MOZILLA UI ***/
        user_pref("browser.privatebrowsing.vpnpromourl", "");
        user_pref("extensions.getAddons.showPane", false);
        user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
        user_pref("browser.discovery.enabled", false);
        user_pref("browser.shell.checkDefaultBrowser", false);
        user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
        user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
        user_pref("browser.preferences.moreFromMozilla", false);
        user_pref("browser.aboutConfig.showWarning", false);
        user_pref("browser.aboutwelcome.enabled", false);
        user_pref("browser.tabs.tabmanager.enabled", false);
        user_pref("browser.profiles.enabled", true);

        /** THEME ADJUSTMENTS ***/
        user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
        user_pref("browser.compactmode.show", true);
        user_pref("browser.display.focus_ring_on_anything", true);
        user_pref("browser.display.focus_ring_style", 0);
        user_pref("browser.display.focus_ring_width", 0);
        user_pref("layout.css.prefers-color-scheme.content-override", 2);
        user_pref("browser.privateWindowSeparation.enabled", false); // WINDOWS
        user_pref("browser.newtabpage.activity-stream.newtabWallpapers.v2.enabled", true);

        /** COOKIE BANNER HANDLING ***/
        user_pref("cookiebanners.service.mode", 1);
        user_pref("cookiebanners.service.mode.privateBrowsing", 1);

        /** FULLSCREEN NOTICE ***/
        user_pref("full-screen-api.transition-duration.enter", "0 0");
        user_pref("full-screen-api.transition-duration.leave", "0 0");
        user_pref("full-screen-api.warning.delay", -1);
        user_pref("full-screen-api.warning.timeout", 0);

        /** URL BAR ***/
        user_pref("browser.urlbar.suggest.calculator", true);
        user_pref("browser.urlbar.unitConversion.enabled", true);
        user_pref("browser.urlbar.trending.featureGate", false);
        user_pref("dom.text_fragments.enabled", true);

        /** NEW TAB PAGE ***/
        user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
        user_pref("browser.newtabpage.activity-stream.showWeather", false);
        user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);

        /** POCKET ***/
        user_pref("extensions.pocket.enabled", false);

        /** DOWNLOADS ***/
        user_pref("browser.download.manager.addToRecentDocs", false);

        /** PDF ***/
        user_pref("browser.download.open_pdf_attachments_inline", true);

        /** TAB BEHAVIOR ***/
        user_pref("browser.bookmarks.openInTabClosesMenu", false);
        user_pref("browser.menu.showViewImageInfo", true);
        user_pref("findbar.highlightAll", true);
        user_pref("layout.word_select.eat_space_to_next_word", false);

        /****************************************************************************
         * START: MY OVERRIDES                                                      *
        ****************************************************************************/
        // visit https://github.com/yokoffing/Betterfox/wiki/Common-Overrides
        // visit https://github.com/yokoffing/Betterfox/wiki/Optional-Hardening
        // Enter your personal overrides below this line:
        // PREF: restore login manager
        user_pref("signon.rememberSignons", true);

        // PREF: restore address and credit card manager
        user_pref("extensions.formautofill.addresses.enabled", true);
        user_pref("extensions.formautofill.creditCards.enabled", true);

        // PREF: allow websites to ask you for your location
        user_pref("permissions.default.geo", 0);

        // PREF: restore search engine suggestions
        user_pref("browser.search.suggest.enabled", true);

        // PREF: enable container tabs
        user_pref("privacy.userContext.enabled", true);

        /****************************************************************************************
         * OPTION: SHARPEN SCROLLING                                                           *
        ****************************************************************************************/
        // credit: https://github.com/black7375/Firefox-UI-Fix
        // only sharpen scrolling
        user_pref("apz.overscroll.enabled", true); // DEFAULT NON-LINUX
        user_pref("general.smoothScroll", true); // DEFAULT
        user_pref("mousewheel.min_line_scroll_amount", 10); // 10-40; adjust this number to your liking; default=5
        user_pref("general.smoothScroll.mouseWheel.durationMinMS", 80); // default=50
        user_pref("general.smoothScroll.currentVelocityWeighting", "0.15"); // default=.25
        user_pref("general.smoothScroll.stopDecelerationWeighting", "0.6"); // default=.4

        /****************************************************************************
         * END: BETTERFOX                                                           *
        ****************************************************************************/
      '';
    };
  };

  stylix.targets.firefox = {
    enable = true;
    colorTheme.enable = true;
    profileNames = ["steven"];
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = ["firefox.desktop"];
    "text/xml" = ["firefox.desktop"];
    "x-scheme-handler/http" = ["firefox.desktop"];
    "x-scheme-handler/https" = ["firefox.desktop"];
  };

  home.persistence."/persist/home/steven" = {
    # I want my history to stay
    directories = [".mozilla/firefox"];
  };
}
