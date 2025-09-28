{inputs, ...}: {
  imports = [inputs.nix-gaming.nixosModules.pipewireLowLatency];

  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    lowLatency = {
      enable = true;
      # If no audio check pipewireLowLatency module dosc at  https://github.com/fufexan/nix-gaming
    };
  };
}
