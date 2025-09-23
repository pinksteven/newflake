{
  config,
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      inputs.nur.modules.nixos.default
      ./auto-upgrade.nix
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
    inherit (config) monitors gamingReady;
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };
  hardware.enableRedistributableFirmware = true;
}
