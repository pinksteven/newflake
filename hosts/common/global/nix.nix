{
  lib,
  pkgs,
  ...
}: {
  nix = {
    package = pkgs.lixPackageSets.latest.lix;
    settings = {
      substituters = [
      ];
      trusted-public-keys = [
      ];

      trusted-users = ["root" "@wheel"];
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
      system-features = [
        "kvm"
        "big-parallel"
        "nixos-test"
      ];
    };
  };
  programs.nix-ld.enable = true;
}
