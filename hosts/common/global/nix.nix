{lib, ...}: {
  nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];

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
}
