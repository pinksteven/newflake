{inputs, ...}: {
  # Import systems from nix-systems for all perSystem modules to use
  systems = import inputs.systems;

  imports = [
    ./modules.nix
    ./overlays.nix
    ./packages.nix
    ./hosts.nix
  ];
}
