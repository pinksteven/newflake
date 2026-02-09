{...}: {
  flake = {
    nixosModules = import ../modules/nixos;
    homeManagerModules = import ../modules/home-manager;
  };
}
