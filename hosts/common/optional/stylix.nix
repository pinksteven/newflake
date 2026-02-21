{
  config,
  inputs,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];

  stylix = {
    enable = true;
    base16Scheme = config.base16-theme;
    fonts = config.fontProfiles;

    # Manage HomeManager stylix independently
    homeManagerIntegration.followSystem = false;

    targets.plymouth.enable = false;
    targets.regreet = {
      enable = true;
      colors.enable = true;
    };
  };
}
