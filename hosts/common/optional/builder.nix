{
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  hosts = lib.attrNames outputs.nixosConfigurations;
  cfg = config.builder;
in {
  options.builder = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether this machine should be used as a remote Nix build machine.";
    };

    maxJobs = lib.mkOption {
      type = lib.types.int;
      default = 4;
      description = "Maximum number of jobs this builder should advertise to remote clients.";
    };

    speedFactor = lib.mkOption {
      type = lib.types.int;
      default = 20;
      description = "Relative speed factor advertised to remote clients.";
    };
  };

  config = lib.mkIf cfg.enable {
    users.groups.builders = {};

    users.users.builder = {
      description = "Account for remote building";
      isSystemUser = true;
      group = "builders";
      shell = pkgs.bashInteractive;
      openssh.authorizedKeys.keyFiles =
        builtins.map (hostname: ../../${hostname}/ssh_host_ed25519_key.pub) hosts;
    };

    nix.settings = {
      max-jobs = "auto";
      speedFactor = cfg.speedFactor;
    };
  };
}
