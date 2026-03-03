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
      extra-substituters = [];
      trusted-public-keys = [];

      max-jobs = lib.mkIf (config.networking.hostName != "kaermorhen") 1;
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
    distributedBuilds = lib.mkIf (config.networking.hostName != "kaermorhen") true;
    buildMachines = lib.mkIf (config.networking.hostName != "kaermorhen") [
      {
        hostName = "kaermorhen";
        sshUser = "builder";
        system = "x86_64-linux";
        sshKey = "/persist/etc/ssh/ssh_host_ed25519_key";
        protocol = "ssh-ng";
        maxJobs = 8;
        speedFactor = 10;
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
