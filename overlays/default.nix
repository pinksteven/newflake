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
          legacyPackages = (flake.legacyPackages or {}).${final.system} or {};
          packages = (flake.packages or {}).${final.system} or {};
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
    # Use newer version of termfilechoose, i need the ghostty fix
    xdg-desktop-portal-termfilechooser = prev.xdg-desktop-portal-termfilechooser.overrideAttrs (
      oldAttrs: {
        src = final.fetchFromGitHub {
          owner = "hunkyburrito";
          repo = "xdg-desktop-portal-termfilechooser";
          rev = "a0291aab4e026f575e5e8927e65f07d3c95dc16c";
          hash = "sha256-H7z+wvA9uXlP1fbTwdJJqscIkXMXuYePJou81jbJKt0=";
        };
      }
    );
  };

  niri = inputs.niri-flake.overlays.niri;
  nvim-pkg = inputs.kickstart-nix.overlays.default;
}
