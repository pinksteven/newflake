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
      speedFactor = lib.mkIf (!(config.builder.enable)) hosts.${name}.config.builder.speedFactor;
      supportedFeatures = ["nixos-test" "kvm" "big-parallel"];
    })
    (lib.filter (name: name != config.networking.hostName) builderHostNames);
in {
  config = {
    nix = {
      package = pkgs.lixPackageSets.latest.lix;
      settings = {
        extra-substituters = ["https://cache.nixos-cuda.org"];
        extra-trusted-public-keys = ["cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="];

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
  };

  # Create builder option
  options.builder = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether this machine should be used as a remote Nix build machine.";
    };

    maxJobs = lib.mkOption {
      type = lib.types.int;
      default = 4;
      description = "Maximum number of jobs this builder should advertise to remote clients.";
    };

    speedFactor = lib.mkOption {
      type = lib.types.int;
      default = 10;
      description = "Relative speed factor advertised to remote clients.";
    };
  };
}
