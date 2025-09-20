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
    extraBackends = let
      epsonscan2 = pkgs.epsonscan2.override {
        withNonFreePlugins = true;
        withGui = false;
      };
    in [
      epsonscan2
      pkgs.sane-airscan
    ];
  };
  services.udev.packages = [pkgs.sane-airscan];
}
