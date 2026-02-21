{
  services.prometheus = {
    enable = true;

    # Define scrape jobs
    scrapeConfigs = [
      {
        job_name = "node";
        static_configs.nodes = ["localhost:9100"];
      }
    ];

    # Exporters
    exporters = {
      node = {
        enable = true;
        port = 9100;
        listenAddress = "0.0.0.0"; # accessible from Tailscale
      };
    };
  };
}
