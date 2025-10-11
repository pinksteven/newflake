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
              Environment = let
                # NixOS system paths that aren't in home-manager's sessionPath
                systemPaths = [
                  "/run/current-system/sw/bin" # NixOS system packages (where steam would be)
                  "/run/wrappers/bin" # Wrapped binaries (sudo, etc.)
                  "/etc/profiles/per-user/${config.home.username}/bin" # User system profile
                ];
              in
                ["PATH=${lib.concatStringsSep ":" (systemPaths ++ config.home.sessionPath)}"]
                ++ (lib.mapAttrsToList (name: value: "${name}=${toString value}")
                  (lib.filterAttrs (name: value: name != "PATH") config.home.sessionVariables));
              ExecStartPre = "${pkgs.coreutils}/bin/sleep 3"; # Give some time for the session to properly start
              ExecStart = "/bin/sh -c '" + (lib.concatStringsSep " " prog.command) + "'";
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
