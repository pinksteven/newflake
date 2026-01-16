{
  pkgs,
  lib,
  ...
}: {
  home = {
    packages = [pkgs.nvim-pkg];
    sessionVariables.EDITOR = lib.mkDefault "nvim";
    persistence."/persist" = {
      files = [".wakatime.cfg"];
      directories = [".local/share/nvim/site/spell"]; # Don't re-download dictionaries every time
    };
  };
}
