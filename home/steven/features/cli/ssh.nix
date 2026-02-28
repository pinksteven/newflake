{
  outputs,
  pkgs,
  lib,
  ...
}: let
  hostnames = builtins.attrNames outputs.nixosConfigurations;
  export-age-key = pkgs.writeShellScriptBin "export-age-key" ''
    mkdir -p ~/.config/sops/age
    SSH_TO_AGE_PASSPHRASE=$(systemd-ask-password) ssh-to-age -private-key -i ~/.ssh/id_masterkey -o ~/.config/sops/age/keys.txt
  '';
in {
  home.packages = [export-age-key];
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        compression = true;
        userKnownHostsFile = "~/.ssh/known_hosts";
        identityFile = "~/.ssh/id_masterkey";
        addKeysToAgent = "1h";
      };
      net = {
        host = lib.concatStringsSep " " hostnames;
        forwardAgent = true;
        remoteForwards = [
          {
            bind.address = ''/%d/.waypipe/server.sock'';
            host.address = ''/%d/.waypipe/client.sock'';
          }
        ];
        forwardX11 = true;
        forwardX11Trusted = true;
        setEnv.WAYLAND_DISPLAY = "wayland-waypipe";
        extraOptions.StreamLocalBindUnlink = "yes";
      };
    };
  };
  services.ssh-agent = {
    enable = true;
  };
}
