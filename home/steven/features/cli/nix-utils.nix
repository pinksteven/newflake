# Entire file from Misterio77/nix-config
{inputs, ...}: {
  imports = [inputs.nix-index-database.homeModules.nix-index];

  programs.nix-index.enable = true;
  programs.nix-index-database.comma.enable = true;
  programs.nix-ld.enable = true;
}
