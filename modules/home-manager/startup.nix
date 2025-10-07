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

  config = lib.mkIf (config.startupPrograms != []) {
    systemd.user.services = lib.mkMerge (map (prog: {
        "${prog.name}-autostart" = {
          Unit = {
            Description = "Autostart program: ${prog.name}";
            After = ["graphical-session.target" "tray.target"];
            Wants = ["graphical-session.target"];
          };
          Service = {
            Type = "oneshot";
            ExecStartPre = "${pkgs.coreutils}/bin/sleep 5"; # Give some time for the session to properly start
            ExecStart = lib.concatStringsSep " " prog.command;
            Restart = "on-failure";
          };
          Install = {
            WantedBy = ["graphical-session.target"];
          };
        };
      })
      config.startupPrograms);
  };
}
