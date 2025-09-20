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

    # For this to work the user needs hm module imported -_-
    # homeManagerIntegration = {
    #   autoImport = false;
    #   followSystem = false;
    # };
    targets.plymouth.enable = false;
  };
}
