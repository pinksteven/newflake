{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-pc-ssd
    inputs.hardware.nixosModules.common-gpu-nvidia-nonprime
    inputs.hardware.nixosModules.common-cpu-amd-pstate

    ./hardware-configuration.nix

    ../common/global
    ../common/users/steven

    ../common/optional/dualboot.nix
    ../common/optional/gamemode.nix
    ../common/optional/greetd.nix
    ../common/optional/kdeconnect.nix
    ../common/optional/pipewire.nix
    ../common/optional/printer.nix
    ../common/optional/quietboot.nix
    ../common/optional/stylix.nix
  ];

  networking.hostName = "gwynbleidd";

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
      width = 2560;
      height = 1440;
      workspace = "1";
      primary = true;
      refreshRate = 144;
      scale = "1.0";
    }
    {
      name = "HDMI-1";
      width = 1080;
      height = 1920;
      workspace = "2";
      primary = false;
      refreshRate = 60;
      scale = "1.0";
    }
  ];

  base16-theme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";

  system.stateVersion = "25.05";
}
