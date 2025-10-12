{inputs, ...}: {
  nixpkgs.hostPlatform = "x86_64-linux";
  imports = [
    inputs.disko.nixosModules.disko
    ../common/optional/ephemeral-btrfs.nix
  ];
  hardware.cpu.intel.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "ondemand";
}
