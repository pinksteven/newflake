{
  systemd = {
    services.duckdns = {
      description = "Update DuckDNS";
      requires = ["network.target"];
      serviceConfig.Type = "oneshot";
      script = ""; # This will come from sops as the script has a token
    };
    timers.duckdns = {
      description = "Update DuckDNS";
      requires = ["network.target"];
      timerConfig = {
        OnBootSec = "1min";
        OnUnitActiveSec = "15min";
        Unit = "duckdns.service";
      };
    };
  };
}
