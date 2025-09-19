{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./auto-upgrade.nix
      ./initrd-systemd.nix
      ./locale.nix
      ./nh.nix
      ./nix.nix
      ./openssh.nix
      ./podman.nix
      ./sops.nix
      ./tailscale.nix
      ./tpm.nix
      ./upower.nix
      ./zsh.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = {inherit inputs outputs;};

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  hardware.enableRedistributableFirmware = true;
}
