{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/steven
  ];

  networking.hostName = "kaermorhen";

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
  };

  programs = {
    dconf.enable = true;
  };

  hardware.graphics.enable = true;

  monitors = [
    {
      name = "DP-1";
      width = 2256;
      height = 1504;
      workspace = [1 2 3 4 5 6 7 8 9 10];
      primary = true;
      refreshRate = 60;
      scale = 1.0;
    }
  ];

  system.stateVersion = "25.05";
}
