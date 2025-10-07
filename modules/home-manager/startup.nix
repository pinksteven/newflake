{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) types mkOption;
in {
  options.startupPrograms = mkOption {
    type = types.listOf (types.submodule {
      options = {
        name = mkOption {
          type = types.str;
          description = "Name of the program (used for service name)";
        };
        command = mkOption {
          type = types.listOf types.str;
          description = "Command to run (as a list of strings)";
        };
      };
    });
    default = [];
    description = "List of programs to autostart via systemd services";
  };

  config.systemd.user = {
    targets.autostart = {
      Unit = {
        Description = "Target for autostarting user programs";
        After =
          ["graphical-session.target" "tray.target"]
          ++ lib.optional (config.wayland.systemd.target != "graphical-session.target") "${config.wayland.systemd.target}";
        Requires = ["graphical-session.target"];
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
    services =
      lib.mkIf (config.startupPrograms != [])
      (lib.mkMerge (map (prog: {
          "${prog.name}-autostart" = {
            Unit = {
              Description = "Autostart program: ${prog.name}";
              After = ["autostart.target"];
              Wants = ["autostart.target"];
              PartOf = ["autostart.target"];
            };
            Service = {
              Type = "exec";
              ExecStartPre = "${pkgs.coreutils}/bin/sleep 3"; # Give some time for the session to properly start
              ExecStart = lib.concatStringsSep " " prog.command;
              Restart = "on-failure";
              X-SwitchMethod = "keep-old";
            };
            Install = {
              WantedBy = ["autostart.target"];
            };
          };
        })
        config.startupPrograms));
  };
}
