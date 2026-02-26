{
  inputs,
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: {
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms-plugin-registry.modules.default
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd = {
      enable = true;
      restartIfChanged = true;
    };

    enableSystemMonitoring = true;
    enableVPN = false; # I don't use a VPN i would want to have a widget for
    enableDynamicTheming = false; # Using stylix for theming
    enableAudioWavelength = true;
    enableCalendarEvents = true;
    enableClipboardPaste = true;

    settings = {
      currentThemeName = "custom";
      currentThemeCategory = "custom";
      customThemeFile = "${config.xdg.configHome}/DankMaterialShell/stylix.json";
      runUserMatugenTemplates = false;
      runDmsMatugenTemplates = false;

      clockDateFormat = "yyyy-MM-dd";
      lockDateFormat = "yyyy-MM-dd";

      weatherEnabled = false;

      fontFamily = config.fontProfiles.sansSerif.name;
      monoFontFamily = config.fontProfiles.monospace.name;

      acMonitorTimeout = 0;
      acLockTimeout = 0;
      acSuspendTimeout = 0;
      acSuspendBehavior = 0;
      batteryMonitorTimeout = 300;
      batteryLockTimeout = 600;
      batterySuspendTimeout = 660;
      batterySuspendBehavior = 2;
      lockBeforeSuspend = true;

      lockScreenShowProfileImage = false;
      lockScreenNotificationMode = 2; # App names only
      enableFprint = osConfig.services.fprintd.enable;

      notificationPopupPosition = 2;
      osdAlwaysShowValue = true;

      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          leftWidgets = ["notificationButton" "workspaceSwitcher" "focusedWindow"];
          centerWidgets = [
            {
              id = "music";
              enabled = true;
              mediaSize = 2;
            }
            "clock"
          ];
          rightWidgets = [
            "tailscale"
            "systemTray"
            "memUsage"
            "battery"
            {
              id = "controlCenterButton";
              enabled = true;
              showAudioPercent = true;
            }
          ];
        }
      ];
      controlCenterWidgets = [
        {
          id = "volumeSlider";
          enabled = true;
          width =
            if osConfig.hardware.capabilities.hasBattery
            then 50
            else 100;
        }
        (lib.mkIf
          osConfig.hardware.capabilities.hasBattery
          {
            id = "brightnessSlider";
            enabled = true;
            width = 50;
          })
        (lib.mkIf
          osConfig.hardware.capabilities.hasWifi
          {
            id = "wifi";
            enabled = true;
            width = 50;
          })
        (lib.mkIf
          osConfig.hardware.capabilities.hasBluetooth
          {
            id = "bluetooth";
            enabled = true;
            width = 50;
          })
        {
          id = "audioOutput";
          enabled = true;
          width = 50;
        }
        {
          id = "audioInput";
          enabled = true;
          width = 50;
        }
        {
          id = "idleInhibitor";
          enabled = true;
          width = 50;
        }
      ];
      powerMenuActions = [
        "reboot"
        "logout"
        "poweroff"
        "lock"
        "suspend"
      ];
      builtInPluginSettings = {
        dms_notepad.enabled = false;
      };
    };
    session = {
      isLightMode = false;
      wallpaperPath = config.wallpaper;
      hiddenOutputDeviceNames = ["easyeffects_sink"];
    };
    plugins = {
      # dankKDEConnect.enable = true; #TODO: figure out enabling this
      dankHooks = {
        enable = true;
        settings = {};
      };
      dankBatteryAlerts = {
        enable = true;
        settings = {
          enableCriticalAlert = true;
          criticalThreshold = 10;
          criticalTitle = "Critical Battery Level";
          criticalMessage = "Critical Battery Level - \${level}%";

          enableWarningAlert = true;
          warningThreshold = 30;
          warningTitle = "Low Battery";
          warningMessage = "Low Battery - \${level}%";
        };
      };
      tailscale.enable = true;
    };
  };

  xdg.configFile."DankMaterialShell/.firstlaunch".text = '''';
  xdg.configFile."DankMaterialShell/stylix.json".text = let
    colors = config.lib.stylix.colors.withHashtag;
  in
    builtins.toJSON {
      name = "Stylix mapped theme";

      background = colors.base00;
      backgroundText = colors.base05;
      surface = colors.base01;
      surfaceText = colors.base05;
      surfaceVariant = colors.base02;
      surfaceVariantText = colors.base04;
      surfaceContainer = colors.base01;
      surfaceContainerHigh = colors.base02;
      surfaceContainerHighest = colors.base03;
      outline = colors.base03;
      primary = colors.base0D;
      primaryText = colors.base00;
      primaryContainer = colors.base0B;
      surfaceTint = colors.base0D;
      secondary = colors.base0E;
      error = colors.base08;
      warning = colors.base0A;
      info = colors.base0C;
    };
}
