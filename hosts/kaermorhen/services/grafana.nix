{config, ...}: {
  sops.secrets = {
    "grafana/secret_key".sopsFile = ../secrets.yaml;
    "grafana/admin_password".sopsFile = ../secrets.yaml;
  };
  services.grafana = {
    enable = true;
    settings = {
      security = {
        secret_key = "\$__file{${config.sops.secrets."grafana/secret_key".path}}";
        admin_password = "\$__file{${config.sops.secrets."grafana/admin_password".path}}";
      };
    };
  };
}
