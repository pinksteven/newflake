{config, ...}: {
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;

    settings = {
      locale = "pl";
      sunshine_name = config.networking.hostName;
      global_prep_cmd = ""; # TODO
    };
  };
}
