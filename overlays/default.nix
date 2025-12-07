{
  outputs,
  inputs,
}: {
  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.system}'
  flake-inputs = final: _: {
    inputs =
      builtins.mapAttrs (
        _: flake: let
          legacyPackages = (flake.legacyPackages or {}).${final.stdenv.hostPlatform.system} or {};
          packages = (flake.packages or {}).${final.stdenv.hostPlatform.system} or {};
        in
          if legacyPackages != {}
          then legacyPackages
          else packages
      )
      inputs;
  };

  additions = final: prev:
    import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    # Always use lix instead of nix
    inherit
      (prev.lixPackageSets.latest)
      nixpkgs-review
      nix-eval-jobs
      nix-fast-build
      colmena
      ;
  };

  niri = inputs.niri-flake.overlays.niri;
  nvim-pkg = inputs.kickstart-nix.overlays.default;
}
