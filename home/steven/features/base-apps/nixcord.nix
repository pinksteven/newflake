{
  inputs,
  config,
  ...
}: {
  home.persistence = {
    "/persist/home/steven" = {
      directories = [
        ".config/vesktop/sessionData"
        ".config/vesktop/settings"
      ];
    };
  };

  imports = [inputs.nixcord.homeModules.nixcord];
  stylix.targets.nixcord.enable = false;
  programs.nixcord = {
    enable = true;
    discord.enable = false;
    vesktop.enable = true;
    config = {
      useQuickCss = true;
      frameless = true;
      disableMinSize = true;
      themeLinks = ["https://refact0r.github.io/midnight-discord/build/midnight.css"];
      enabledThemes = ["nixnight.css"];

      plugins = {
        alwaysAnimate.enable = true;
        alwaysExpandRoles.enable = true;
        alwaysTrust.enable = true;
        anonymiseFileNames.enable = true;
        betterGifAltText.enable = true;
        betterSettings.enable = true;
        betterUploadButton.enable = true;
        biggerStreamPreview.enable = true;
        blurNSFW.enable = true;
        callTimer.enable = true;
        clearURLs.enable = true;
        copyFileContents.enable = true;
        copyUserURLs.enable = true;
        crashHandler.enable = true;
        disableCallIdle.enable = true;
        fakeNitro.enable = true;
        fakeProfileThemes.enable = true;
        fixImagesQuality.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        gameActivityToggle.enable = true;
        gifPaste.enable = true;
        hideMedia.enable = true;
        mentionAvatars.enable = true;
        noReplyMention.enable = true;
        openInApp.enable = true;
        platformIndicators.enable = true;
        roleColorEverywhere.enable = true;
        shikiCodeblocks.enable = true;
        showMeYourName = {
          enable = true;
          mode = "nick-user";
        };
        silentTyping = {
          enable = true;
          showIcon = true;
        };
        spotifyControls = {
          enable = true;
          hoverControls = true;
        };
        typingTweaks.enable = true;
        userVoiceShow.enable = true;
        validReply.enable = true;
        voiceChatDoubleClick.enable = true;
        viewIcons.enable = true;
        whoReacted.enable = true;
        newGuildSettings = {
          enable = true;
          messages = "only@Mentions";
        };
      };
    };
  };
  home.file."${config.programs.nixcord.vesktop.configDir}/themes/nixnight.css".text = with config.lib.stylix.colors.withHashtag; # css
  
    ''
        body {
          /* font, change to "" for default discord font */
          --font: '${config.stylix.fonts.serif.name}';

          /* sizes */
          --gap: 12px; /* spacing between panels */
          --divider-thickness: 4px; /* thickness of unread messages divider and highlighted message borders */

          /* animation/transition options */
          --animations: on; /* turn off to disable all midnight animations/transitions */
          --list-item-transition: 0.2s ease; /* transition for list items */
          --dms-icon-svg-transition: 0.4s ease; /* transition for the dms icon */

          /* top bar options */
          --move-top-bar-buttons: off; /* turn on to move inbox button to the server list (recommend setting top bar height to 24px) */
          --custom-app-top-bar-height: 32px; /* height of the titlebar/top bar (default is 36px)*/

          /* window controls */
          --custom-window-controls: on; /* turn off to use discord default window controls */
          --window-control-size: 14px; /* size of custom window controls */

          /* dms button icon options */
          --dms-icon: on; /* set to default to use discord icon, on to use custom icon, off to disable completely */
          --dms-icon-svg-url: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 27 27' width='24' height='24'%3E%3Cpath fill='currentColor' d='M0 0h7v1H6v1H5v1H4v1H3v1H2v1h5v1H0V6h1V5h1V4h1V3h1V2h1V1H0m13 2h5v1h-1v1h-1v1h-1v1h3v1h-5V7h1V6h1V5h1V4h-3m8 5h1v5h1v-1h1v1h-1v1h1v-1h1v1h-1v3h-1v1h-2v1h-1v1h1v-1h2v-1h1v2h-1v1h-2v1h-1v-1h-1v1h-6v-1h-1v-1h-1v-2h1v1h2v1h3v1h1v-1h-1v-1h-3v-1h-4v-4h1v-2h1v-1h1v-1h1v2h1v1h1v-1h1v1h-1v1h2v-2h1v-2h1v-1h1M8 14h2v1H9v4h1v2h1v1h1v1h1v1h4v1h-6v-1H5v-1H4v-5h1v-1h1v-2h2m17 3h1v3h-1v1h-1v1h-1v2h-2v-2h2v-1h1v-1h1m1 0h1v3h-1v1h-2v-1h1v-1h1'%3E%3C/path%3E%3C/svg%3E"); /* icon svg url. MUST BE A SVG. */
          --dms-icon-svg-size: 90%; /* size of the svg (css mask-size) */
          --dms-icon-color-before: var(--icon-primary); /* normal icon color */
          --dms-icon-color-after: var(--white); /* icon color when button is hovered/selected */

          /* dms button background options */
          --dms-background: off; /* off to disable, image to use a background image, color to use a custom color/gradient */
          --dms-background-image-url: url(\'\'); /* url of the background image */
          --dms-background-image-size: cover; /* size of the background image (css background-size) */
          --dms-background-color: linear-gradient(70deg, var(--blue-2), var(--purple-2), var(--red-2)); /* fixed color/gradient (css background) */

          /* transparency/blur options */
          /* NOTE: TO USE TRANSPARENCY/BLUR, YOU MUST HAVE TRANSPARENT BG COLORS. FOR EXAMPLE: --bg-4: hsla(220, 15%, 10%, 0.7); */
          --transparency-tweaks: off; /* turn on to remove some elements for better transparency */
          --remove-bg-layer: off; /* turn on to remove the base --bg-3 layer for use with window transparency (WILL OVERRIDE BACKGROUND IMAGE) */
          --panel-blur: off; /* turn on to blur the background of panels */
          --blur-amount: 12px; /* amount of blur */
          --bg-floating: var(--bg-3); /* you can set this to a more opaque color if floating panels look too transparent */

          /* chatbar options */
          --flipped-chatbar: on; /* turn on to move the typing indicator above the chatbar */
          --chatbar-height: 47px; /* height of the chatbar (52px by default, 47px to align it with the user panel) */
          --chatbar-padding: 8px; /* padding of the chatbar */

          /* other options */
          --small-user-panel: off; /* turn on to make the user panel smaller like in old discord */
      }

      /* color options */
      :root {
        --colors: on; /* turn off to use discord default colors */

        /* text colors */
        --text-0: var(--bg-4); /* text on colored elements */
        --text-1: ${base06}; /* bright text on colored elements */
        --text-2: ${base06}; /* headings and important text */
        --text-3: ${base05}; /* normal text */
        --text-4: ${base05}; /* icon buttons and channels */
        --text-5: ${base04}; /* muted channels/chats and timestamps */

        /* background and dark colors */
        --bg-1: ${base0D}; /* dark buttons when clicked */
        --bg-2: ${base02}; /* dark buttons */
        --bg-3: ${base01}; /* spacing, secondary elements */
        --bg-4: ${base00}; /* main background color */
        --hover: ${base03}1a; /* channels and buttons when hovered */
        --active: ${base03}33; /* channels and buttons when clicked or selected */
        --active-2: ${base03}10; /* extra state for transparent buttons */
        --message-hover: hsla(0, 0%, 0%, 0.1); /* messages when hovered */

        /* accent colors */
        --accent-1: ${base0D}; /* links and other accent text */
        --accent-2: ${base0D}; /* small accent elements */
        --accent-3: ${base0D}; /* accent buttons */
        --accent-4: ${base0D}; /* accent buttons when hovered */
        --accent-5: ${base0D}; /* accent buttons when clicked */
        --accent-new: var(--accent-2); /* stuff that's normally red like mute/deafen buttons */
        --mention: linear-gradient(to right, color-mix(in hsl, var(--accent-2), transparent 90%) 40%, transparent); /* background of messages that mention you */
        --mention-hover: linear-gradient(to right, color-mix(in hsl, var(--accent-2), transparent 95%) 40%, transparent); /* background of messages that mention you when hovered */
        --reply: linear-gradient(to right, color-mix(in hsl, var(--text-3), transparent 90%) 40%, transparent); /* background of messages that reply to you */
        --reply-hover: linear-gradient(to right, color-mix(in hsl, var(--text-3), transparent 95%) 40%, transparent); /* background of messages that reply to you when hovered */

        /* status indicator colors */
        --online: var(--green-2); /* change to #43a25a for default */
        --dnd: var(--red-2); /* change to #d83a42 for default */
        --idle: var(--yellow-2); /* change to #ca9654 for default */
        --streaming: var(--purple-2); /* change to #593695 for default */
        --offline: var(--text-4); /* change to #83838b for default offline color */

        /* border colors */
        --border-light: var(--hover); /* light border color */
        --border: var(--active); /* normal border color */
        --button-border: hsl(0, 0%, 100%, 0.1); /* neutral border color of buttons */

        /* base colors */
        --red-1: ${base08};
        --red-2: ${base08};
        --red-3: ${base08};
        --red-4: ${base08};
        --red-5: ${base08};

        --green-1: ${base0B};
        --green-2: ${base0B};
        --green-3: ${base0B};
        --green-4: ${base0B};
        --green-5: ${base0B};

        --blue-1: ${base0C};
        --blue-2: ${base0C};
        --blue-3: ${base0C};
        --blue-4: ${base0C};
        --blue-5: ${base0C};

        --yellow-1: ${base0A};
        --yellow-2: ${base0A};
        --yellow-3: ${base0A};
        --yellow-4: ${base0A};
        --yellow-5: ${base0A};

        --purple-1: ${base0E};
        --purple-2: ${base0E};
        --purple-3: ${base0E};
        --purple-4: ${base0E};
        --purple-5: ${base0E};
      }
    '';
}
