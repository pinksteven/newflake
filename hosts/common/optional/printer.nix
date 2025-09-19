{pkgs, ...}: {
  services = {
    printing = {
      enable = true;
      cups-pdf.enable = true;
      drivers = with pkgs; [gutenprint epson-escpr];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.epsonscan2.override
      {
        withNonFreePlugins = true;
        withGui = false;
      }
      pkgs.sane-airscan
    ];
  };
  services.udev.packages = [pkgs.sane-airscan];
}
