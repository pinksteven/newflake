{inputs, ...}: {
  imports = [inputs.caelestia-shell.homeManagerModules.default];

  programs.caelestia = {
    enable = true;
    systemd.enable = true;
    settings = {
      background.enabled = false;
    };
  };
}
