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
      substituters = [
        (
          if (config.networking.hostName != "kaermorhen")
          then "ssh-ng://kaermorhen"
          else null
        )
      ];
      trusted-public-keys = [];

      trusted-users = ["root" "@wheel"];
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
      keys = builtins.filter (x: x != null) (builtins.map (hostname:
        if hostname != "kaermorhen"
        then (builtins.readFile ../../${hostname}/ssh_host_ed25519_key.pub)
        else null)
      hosts);
    };
    distributedBuilds = lib.mkIf (config.networking.hostName != "kaermorhen") true;
    buildMachines = lib.mkIf (config.networking.hostName != "kaermorhen") [
      {
        hostName = "kaermorhen";
        sshUser = "steven";
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
}
