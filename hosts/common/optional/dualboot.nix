{lib, ...}: {
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = lib.mkForce true;
      devices = ["nodev"];
      efiSupport = true;
      useOSProber = true;
    };
  };
}
