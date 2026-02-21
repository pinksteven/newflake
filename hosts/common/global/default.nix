{
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      inputs.nur.modules.nixos.default
      ./impermanence.nix
      ./initrd-systemd.nix
      ./locale.nix
      ./nh.nix
      ./nix.nix
      ./openssh.nix
      ./podman.nix
      ./polkit.nix
      ./sops.nix
      ./tailscale.nix
      ./tpm.nix
      ./udisks2.nix
      ./upower.nix
      ./zsh.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  boot.loader.systemd-boot.enable = lib.mkDefault true;

  nixpkgs = {
    overlays =
      [
        (final: prev: {
          inherit
            (prev.lixPackageSets.stable)
            nixpkgs-review
            nix-eval-jobs
            nix-fast-build
            colmena
            ;
        })
      ]
      ++ builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      # Untill i find a different mod manager
      permittedInsecurePackages = ["nexusmods-app-unfree-0.21.1"];
    };
  };

  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;
  };

  security.pam.services.login = {
    fprintAuth = false;
  };

  environment.systemPackages = [pkgs.git];

  hardware.enableRedistributableFirmware = true;
}
