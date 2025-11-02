{
  config,
  lib,
  ...
}: {
  programs.waybar = let
    hasBluetooth =
      builtins.pathExists /sys/class/bluetooth
      || builtins.pathExists /proc/bluetooth
      || (builtins.pathExists /sys/bus/usb/devices
        && lib.any (name: lib.hasInfix "bluetooth" (lib.toLower name))
        (lib.attrNames (builtins.readDir /sys/bus/usb/devices)));
  in {
    enable = true;
    systemd.enable = true;

    settings = [
      {
        layer = "top";
        position = "top";
        modules-left = ["custom/notifications" "clock" "custom/stasis" "custom/separator" "niri/workspaces"];
        modules-center = ["niri/window"];
        modules-right =
          ["group/expand" "tray" "custom/separator" "wireplumber"]
          ++ lib.optionals hasBluetooth "bluetooth"
          ++ ["network" "battery" "power-profiles-daemon"];

        "custom/notification" = {
          tooltip = true;
          format = "{icon}";
          format-icons = {
            notification = "󱅫 ";
            none = "󰂜 ";
            dnd-notification = "󰂠 ";
            dnd-none = "󰪓 ";
            inhibited-notification = "󰂛 ";
            inhibited-none = "󰪑 ";
            dnd-inhibited-notification = "󰂛 ";
            dnd-inhibited-none = "󰪑 ";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        clock = {
          format = "{:%H:%M  %F}";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            format = {
              today = "<span color='#fAfBfC'><b>{}</b></span>";
            };
          };
          actions = {
            on-click-right = "shift_down";
            on-click = "shift_up";
          };
        };

        "custom/stasis" = {
          exec = "stasis info --json";
          format = "{icon}";
          format-icons = {
            idle_active = "󰾫";
            idle_inhibited = "󰛊";
            manually_inhibited = "󰛊";
            not_running = "󰒲";
          };
          tooltip = true;
          on-click = "stasis toggle-inhibit";
          interval = 2;
          restart-interval = 2;
          return-type = "json";
        };

        "niri/window" = {
          format = "{app_id}   {title}";
        };

        tray = {
          icon-size = 14;
          spacing = 10;
        };

        bluetooth = {
          format-on = "󰂯";
          format-disabled = "󰂲";
          format-connected = "󰂱";
          format-connected-battery = "{device_battery_percentage}% 󰂱";
          format-alt = "{device_alias} 󰂯";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\n{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\n{device_address}\n{device_battery_percentage}%";
          on-click-right = "overskride";
        };

        network = {
          format-wifi = " ";
          format-ethernet = " ";
          format-disconnected = " ";
          tooltip-format-disconnected = "Error";
          tooltip-format-wifi = "{essid} ({signalStrength}%)  ";
          tooltip-format-ethernet = "{ifname}  ";
          on-click = "kitty nmtui";
        };

        wireplumber = {
          format = "{icon}";
          format-muted = " ";
          on-click = "pavucontrol";
          reverse-scrolling = true;
          reverse-mouse-scrolling = false;
          format-icons = [" " " " " "];
        };

        battery = {
          interval = 30;
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰂄";
          format-plugged = "{capacity}% 󰂄 ";
          format-alt = "{time} {icon}";
          format-icons = ["󰁻" "󰁼" "󰁾" "󰂀" "󰂂" "󰁹"];
        };

        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          tooltip = true;
          format-icons = {
            default = " ";
            performance = " ";
            balanced = " ";
            power-saver = " ";
          };
        };

        "custom/expand" = {
          format = "";
          tooltip = false;
        };
        "custom/separator" = {
          "format" = "";
          "tooltip" = false;
        };
        "group/expand" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 600;
            transition-to-left = true;
            click-to-reveal = true;
          };
          modules = ["custom/expand" "cpu" "memory" "temperature" "custom/separator"];
        };

        cpu = {
          format = "󰻠 ";
          tooltip = true;
        };
        memory = {
          format = "";
        };
        temperature = {
          critical-threshold = 80;
          format = "";
        };
      }
    ];
    style = let
      colors = config.lib.stylix.colors.withHashtag;
      font = config.stylix.fonts.serif.name;
    in
      #css
      ''

        * {
            font-size:15px;
            font-family: "${font}";
        }
        window#waybar{
            all:unset;
        }
        .modules-left {
            padding:7px;
            margin:10 0 5 10;
            border-radius:10px;
            background: alpha(${colors.base00},.6);
            box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
        }
        .modules-center {
            padding:7px;
            margin:10 0 5 0;
            border-radius:10px;
            background: alpha(${colors.base00},.6);
            box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
        }
        .modules-right {
            padding:7px;
            margin: 10 10 5 0;
            border-radius:10px;
            background: alpha(${colors.base00},.6);
            box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
        }
        tooltip {
            background:${colors.base00};
            color: @color7;
        }
        #clock:hover,#custom-notification:hover,#bluetooth:hover,#network:hover,#battery:hover, #cpu:hover,#memory:hover,#temperature:hover,#wireplumber:hover{
            transition: all .3s ease;
            color:@color9;
        }
        #custom-notification {
            padding: 0px 5px;
            transition: all .3s ease;
            color:@color7;
        }
        #clock{
            padding: 0px 5px;
            color:@color7;
            transition: all .3s ease;
        }
        #custom-pacman{
            padding: 0px 5px;
            transition: all .3s ease;
            color:@color7;

        }
        #workspaces {
            padding: 0px 5px;
        }
        #workspaces button {
            all:unset;
            padding: 0px 5px;
            color: alpha(${colors.base0D},.4);
            transition: all .2s ease;
        }
        #workspaces button:hover {
            color:rgba(0,0,0,0);
            border: none;
            text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .5);
            transition: all 1s ease;
        }
        #workspaces button.active {
            color: ${colors.base0D};
            border: none;
            text-shadow: 0px 0px 2px rgba(0, 0, 0, .5);
        }
        #workspaces button.empty {
            color: rgba(0,0,0,0);
            border: none;
            text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .2);
        }
        #workspaces button.empty:hover {
            color: rgba(0,0,0,0);
            border: none;
            text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .5);
            transition: all 1s ease;
        }
        #workspaces button.empty.active {
            color: ${colors.base0D};
            border: none;
            text-shadow: 0px 0px 2px rgba(0, 0, 0, .5);
        }
        #bluetooth{
            padding: 0px 5px;
            transition: all .3s ease;
            color:@color7;

        }
        #network{
            padding: 0px 5px;
            transition: all .3s ease;
            color:${colors.base07};

        }
        #battery{
            padding: 0px 5px;
            transition: all .3s ease;
            color:${colors.base07};


        }
        #battery.charging {
            color: #26A65B;
        }

        #battery.warning:not(.charging) {
            color: #ffbe61;
        }

        #battery.critical:not(.charging) {
            color: #f53c3c;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }
        #group-expand{
            padding: 0px 5px;
            transition: all .3s ease;
        }
        #custom-expand{
            padding: 0px 5px;
            color:alpha(${colors.base02},.2);
            text-shadow: 0px 0px 2px rgba(0, 0, 0, .7);
            transition: all .3s ease;
        }
        #custom-expand:hover{
            color:rgba(255,255,255,.2);
            text-shadow: 0px 0px 2px rgba(255, 255, 255, .5);
        }
        #custom-colorpicker{
            padding: 0px 5px;
        }
        #cpu,#memory,#temperature{
            padding: 0px 5px;
            transition: all .3s ease;
            color:${colors.base07};

        }
        #custom-endpoint{
            color:transparent;
            text-shadow: 0px 0px 1.5px rgba(0, 0, 0, 1);

        }
        #tray{
            padding: 0px 5px;
            transition: all .3s ease;

        }
        #tray menu * {
            padding: 0px 5px;
            transition: all .3s ease;
        }

        #tray menu separator {
            padding: 0px 5px;
            transition: all .3s ease;
        }
      '';
  };
}
