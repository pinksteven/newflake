{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: {
  imports =
    [
      inputs.impermanence.homeManagerModules.impermanence
      ../features/cli
      # ../features/nvim
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  nix = {
    package = lib.mkForce pkgs.lixPackageSets.latest.lix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  systemd.user.startServices = "sd-switch";

  fonts.fontconfig.enable = true;

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "steven";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "25.05";
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      NH_FLAKE = "$HOME/Documents/newflake";
    };

    persistence."/persist/home/steven" = {
      directories = [
        "Desktop"
        "Documents"
        "Downloads"
        "Pictures"
        "Videos"
        "Sync"
        ".ssh"
        ".local/bin"
        ".local/state/wireplumber"
        ".local/share/nix" # trusted settings and repl history
      ];
      allowOther = true;
    };
  };
}
