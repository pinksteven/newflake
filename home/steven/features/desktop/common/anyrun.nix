{
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.inputs.kidex.kidex];
  xdg.configFile."kidex.ron".text = ''
    Config(
      ignored: [".*",],
      directories: [
        WatchDir(
          path: "/home/steven",
          recurse: true,
          ignored: ["BigDisk",],
        ),
      ],
    )
  '';

  programs.anyrun = {
    enable = true;
    config = {
      plugins = [
        "${pkgs.anyrun}/lib/libapplications.so"
        "${pkgs.anyrun}/lib/libsymbols.so"
        "${pkgs.anyrun}/lib/librink.so"
        "${pkgs.anyrun}/lib/libkidex.so"
      ];

      # Position and size
      x.fraction = 0.5;
      y.absolute = 0;
      width.fraction = 0.33;
      height.absolute = 1;

      # Options
      closeOnClick = true;
    };

    extraConfigFiles = {
      "applications.ron".text = ''
        Config(
          desktop_actions: true,
          max_entries: 5,
        )
      '';
      "symbols.ron".text = ''
        Config(
          prefix:">s",
          max_entries:5,
        )
      '';
      "kidex.ron".text = ''
        Config(
          max_entries:5,
        )
      '';
      "stdin.ron".text = ''
        Config(
          max_entries: 15,
        )
      '';
    };

    extraCss =
      # CSS
      ''
        window {
          background: transparent;
        }

        box.main {
          padding: 5px;
          margin: 10px;
          border-radius: 10px;
          border: 2px solid @theme_selected_bg_color;
          background-color: @theme_bg_color;
          box-shadow: 0 0 5px black;
        }


        text {
          min-height: 30px;
          padding: 5px;
          border-radius: 5px;
        }

        .matches {
          background-color: rgba(0, 0, 0, 0);
          border-radius: 10px;
        }

        box.plugin:first-child {
          margin-top: 5px;
        }

        box.plugin.info {
          min-width: 200px;
        }

        list.plugin {
          background-color: rgba(0, 0, 0, 0);
        }

        label.match.description {
          font-size: 10px;
        }

        label.plugin.info {
          font-size: 14px;
        }

        .match {
          background: transparent;
        }

        .match:selected {
          border-left: 4px solid @theme_selected_bg_color;
          background: transparent;
          animation: fade 0.1s linear;
        }

        @keyframes fade {
          0% {
            opacity: 0;
          }

          100% {
            opacity: 1;
          }
        }
      '';
  };

  systemd.user.services.kidex = {
    Unit = {
      Description = "A simple file indexing service";
      PartOf = "graphical-session.target";
      After = "graphical-session.target";
      Requisite = "graphical-session.target";
    };
    Service = {
      Type = "exec";
      ExecStart = "${lib.getExe pkgs.inputs.kidex.kidex}";
      Restart = "on-failure";
    };
  };
}
