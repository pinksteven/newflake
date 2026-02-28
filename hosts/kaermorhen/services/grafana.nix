{config, ...}: {
  sops.secrets = {
    "grafana/secret_key".sopsFile = {
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
      security = {
        secret_key = "\$__file{${config.sops.secrets."grafana/secret_key".path}}";
        admin_password = "\$__file{${config.sops.secrets."grafana/admin_password".path}}";
      };
      server = {
        http_addr = "127.0.0.1";
        http_port = 2342;
      };
    };
  };
}
