{config, ...}: {
  sops.secrets = {
    "grafana/secret_key" = {
      mode = "0600";
      owner = "grafana";
      sopsFile = ../secrets.yaml;
    };
    "grafana/admin_password" = {
      mode = "0600";
      owner = "grafana";
      sopsFile = ../secrets.yaml;
    };
  };
  services.grafana = {
    enable = true;
    settings = {
      analytics.reporting_enabled = false;
      security = {
        secret_key = "\$__file{${config.sops.secrets."grafana/secret_key".path}}";
        admin_user = "steven";
        admin_password = "\$__file{${config.sops.secrets."grafana/admin_password".path}}";
      };
      server = {
        domain = "localhost";
        http_addr = "127.0.0.1";
        http_port = 3000;
      };
    };
  };
  services.tailscale.serve.services.grafana = {
    endpoints = {
      "tcp:443" = "http://localhost:3000";
    };
    advertised = true;
  };
}
