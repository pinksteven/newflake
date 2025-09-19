{lib, ...}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = lib.mkDefault "client";
    openFirewall = true;
  };

  environment.persistence = {
    "/persist".directories = [
      {
        directory = "/var/lib/tailscale";
      }
    ];
  };
}
