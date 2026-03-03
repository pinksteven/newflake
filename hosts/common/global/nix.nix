{
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  hosts = lib.attrNames outputs.nixosConfigurations;
in {
  nix = {
    package = pkgs.lixPackageSets.latest.lix;
    settings = {
      substituters =
        []
        ++ lib.optionals (config.networking.hostName != "kaermorhen") ["ssh-ng://kaermorhen"];
      trusted-public-keys = [];

      trusted-users = ["root" "@wheel" "@builders"];
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
      system-features = [
        "kvm"
        "big-parallel"
        "nixos-test"
      ];
    };
    optimise = {
      automatic = true;
    };
    sshServe = lib.mkIf (config.networking.hostName == "kaermorhen") {
      enable = true;
      protocol = "ssh-ng";
      keys = builtins.map (hostname:
        lib.removeSuffix "\n" (builtins.readFile ../../${hostname}/ssh_host_ed25519_key.pub))
      (builtins.filter (x: x != "kaermorhen") hosts);
    };
    distributedBuilds = lib.mkIf (config.networking.hostName != "kaermorhen") true;
    buildMachines = lib.mkIf (config.networking.hostName != "kaermorhen") [
      {
        hostName = "kaermorhen";
        sshUser = "builder";
        system = "x86_64-linux";
        sshKey = "/persist/etc/ssh/ssh_host_ed25519_key";
        protocol = "ssh-ng";
        supportedFeatures = ["nixos-test" "kvm" "big-parallel"];
      }
    ];
    extraOptions = lib.mkIf (config.networking.hostName != "kaermorhen") ''
      builders-use-substitutes = true
    '';
  };
  programs.nix-ld.enable = true;
  users.groups.builders = {};
  users.users.builder = lib.mkIf (config.networking.hostName == "kaermorhen") {
    description = "Account for remote building";
    isSystemUser = true;
    group = "builders";
    shell = pkgs.bashInteractive;
    openssh.authorizedKeys.keyFiles = builtins.map (hostname: ../../${hostname}/ssh_host_ed25519_key.pub) hosts;
  };
}
