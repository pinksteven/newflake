{
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  hosts = lib.attrNames outputs.nixosConfigurations;
in {
  config = {
    builder.enable = true;

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
    };
  };
}
