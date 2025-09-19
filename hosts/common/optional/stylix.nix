{
  config,
  inputs,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];

  stylix = {
    enable = true;
    base16Scheme = config.base16-theme;
    inherit (config) fonts;

    homeManagerIntergration = {
      autoImport = false;
      followSystem = false;
    };
    targets.plymouth.enable = false;
  };
}
