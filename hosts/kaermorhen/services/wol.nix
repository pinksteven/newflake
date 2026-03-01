{
  pkgs,
  config,
  ...
}: let
  wol = pkgs.writeShellScriptBin "wol" ''
    set -euo pipefail
    source ${config.sops.secrets.wol.path}

    TARGET="$1"
    MAC="${!TARGET:-}"

    if [ -z "${MAC:-}" ]; then
      echo "Unknown target"
      exit 1
    fi

    exec wakeonlan "$MAC"
  '';
in {
  sops.secrets.wol = {
    sopsFile = ../secrets.yaml;
  };
  environment.systemPackages = with pkgs; [
    wakeonlan
  ];
}
