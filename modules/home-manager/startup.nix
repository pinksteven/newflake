{lib, ...}: let
  inherit (lib) types mkOption;
in {
  options.startupPrograms = mkOption {
    type = types.listOf (types.submodule
      ({config, ...}: {
        options = {
          delay = mkOption {
            type = types.int;
            default = 0;
            description = "Delay in seconds before starting the program";
          };
          command = mkOption {
            type = types.listOf types.str;
            description = "Command to run (as a list of strings)";
          };

          startupCmd = mkOption {
            type = types.str;
            default =
              if config.delay > 0
              then "sleep ${toString config.delay} && ${lib.escapeShellArgs config.command}"
              else lib.escapeShellArgs config.command;
            description = "Computed startup command with delay";
            readOnly = true;
          };
        };
      }));
    default = [];
    description = "List of programs to autostart via wm config";
  };
}
