{lib, ...}: {
  nix.settings = {
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
