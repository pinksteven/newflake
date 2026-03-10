{
  pkgs,
  lib,
  ...
}: {
  home = {
    packages = [pkgs.neovim];
    sessionVariables.EDITOR = lib.mkDefault "nvim";
    persistence."/persist" = {
      directories = [".local/share/nvim/site/spell"]; # Don't re-download dictionaries every time
    };
  };
}
