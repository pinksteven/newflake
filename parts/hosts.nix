{
  inputs,
  self,
  ...
}: let
  lib = inputs.nixpkgs.lib // inputs.home-manager.lib;
in {
  # Configure nixpkgs once for all perSystem modules
  perSystem = {system, ...}: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = builtins.attrValues self.overlays;
    };
  };

  # NixOS configurations
  flake.nixosConfigurations = {
    # Main desktop
    gwynbleidd = lib.nixosSystem {
      modules = [../hosts/gwynbleidd];
      specialArgs = {
        inherit inputs;
        outputs = self;
      };
    };

    # Personal laptop
    zireael = lib.nixosSystem {
      modules = [../hosts/zireael];
      specialArgs = {
        inherit inputs;
        outputs = self;
      };
    };

    # To Be Deployed Home Server
    kaermorhen = lib.nixosSystem {
      modules = [../hosts/kaermorhen];
      specialArgs = {
        inherit inputs;
        outputs = self;
      };
    };
  };
}
