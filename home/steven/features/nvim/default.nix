{
  pkgs,
  lib,
  ...
}: {
  home = {
    packages = [pkgs.nvim-pkg];
    sessionVariables.EDITOR = lib.mkDefault "nvim";
    persistence."/persist/home/steven" = {
      files = [".wakatime.cfg"];
      directories = [".local/share/nvim/site/spell"]; # Don't re-download dictionaries every time
    };
  };
}
