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

      # Latency theoretical latency is quantum/rate
      # which is 1.3ms for default values
      quantum = 64; # Default is 64
      rate = 48000; # Default is 48k
    };

    extraConfig = {
      pipewire-pulse = {
        # Increasing quantum(buffer size) for pulse backend emulation
        # pulseaudio was never built for realtime/low-latency and it can cause problems
        # it did in modded minecraft for me. Anything remotely caring for low latency should use other backend anyway
        "context.properties" = {
          pulse.min.req = "128/48000";
          pulse.default.req = "256/48000";
          pulse.max.req = "512/48000";
        };
      };
    };
  };
}
