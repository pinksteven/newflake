{
  pkgs,
  config,
  ...
}: let
  remote-login = pkgs.writeShellScriptBin "remote-login" ''
    set -eu

    if [ "${"$"}{1:-}" = "" ]; then
      echo "Usage: $0 <user> [vt]" >&2
      exit 2
    fi

    USER_TO_START="$1"
    TTY="${"$"}{2:-2}"  # default VT is 2 when not provided
    case "$TTY" in
      \'\'|*[!0-9]*) echo "VT must be a number" >&2; exit 2;;
    esac

    exec ${pkgs.kbd}/bin/openvt -c "$TTY" -f -- su -l "$USER_TO_START" -e 'exec niri-session'
  '';
in {
  environment.systemPackages = [remote-login];
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
