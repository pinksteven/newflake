{
  inputs,
  pkgs,
  config,
  self,
  ...
}: let
  nixvim' = inputs.nixvim.packages."${pkgs.system}".default;
  nixvim = nixvim'.extend {
    lsp.servers.nixd.settings.settings.options = {
      nixos.expr = ''(builtins.getFlake "${self}")'';
      home-manager.expr = ''(builtins.getFlake "${self}")'';
    };
  };
  nvim =
    if config.stylix.enable
    then (nixvim.extend config.lib.stylix.nixvim.config)
    else nixvim;
in {
  home = {
    packages = [nvim];
    sessionVariables.EDITOR = "nvim";
    persistence."/persist".files = [".wakatime.cfg"];
  };
}
