{
  lib,
  pkgs,
  ...
}: {
  nix = {
    package = pkgs.lixPackageSets.latest.lix;
    settings = {
      substituters = [
        "https://nix-gaming.cachix.org"
        "https://niri.cachix.org"
      ];
      trusted-public-keys = [
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];

      trusted-users = ["root" "@wheel"];
      auto-optimise-store = lib.mkDefault true;
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
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
