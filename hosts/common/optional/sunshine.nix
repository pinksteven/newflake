{config, ...}: {
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;

    settings = {
      locale = "en";
      sunshine_name = config.networking.hostName;
      global_prep_cmd = ""; # TODO
      nvenc_spatial_aq = "enabled"; # I assume i will stream at low bitrates
    };
  };
}
