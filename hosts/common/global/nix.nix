{
  outputs,
  lib,
  config,
  pkgs,
  ...
}: let
  hosts = outputs.nixosConfigurations;

  # All host names where `config.builder = true`
  builderHostNames =
    lib.filter
    (name: (hosts.${name}.config.builder.enable or false))
    (lib.attrNames outputs.nixosConfigurations);

  # Build machine entries for all builder hosts except self
  buildMachinesForThisHost =
    map (name: {
      hostName = name;
      sshUser = "builder";
      system = hosts.${name}.pkgs.stdenv.hostPlatform.system;
      sshKey = "/persist/etc/ssh/ssh_host_ed25519_key";
      protocol = "ssh-ng";
      maxJobs = hosts.${name}.config.builder.maxJobs;
      speedFactor = hosts.${name}.config.builder.speedFactor;
      supportedFeatures = ["nixos-test" "kvm" "big-parallel"];
    })
    (lib.filter (name: name != config.networking.hostName) builderHostNames);
in {
  nix = {
    package = pkgs.lixPackageSets.latest.lix;
    settings = {
      extra-substituters = [];
      trusted-public-keys = [];

      max-jobs = lib.mkDefault 1;
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
    distributedBuilds = lib.mkDefault true;
    buildMachines = buildMachinesForThisHost;
    extraOptions = ''
      builders-use-substitutes = true
    '';
  };
  programs.nix-ld.enable = true;
}
