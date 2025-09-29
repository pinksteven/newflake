{
  config,
  lib,
  pkgs,
  ...
}: {
  services.greetd = {
    enable = true;
  };

  programs.regreet = {
    enable = true;
    cageArgs = ["-s" "-m" "last"];
  };

  environment.persistence = {
    # Persist last user and last selected session
    "/persist".directories = [
      {
        directory = "/var/lib/regreet";
        user = "greeter";
        group = "greeter";
      }
    ];
  };

  services.displayManager.sessionPackages = let
    withNiri =
      builtins.any
      (cfg: lib.attrByPath ["programs" "niri" "enable"] false cfg)
      (builtins.attrValues config.home-manager.users);
  in
    lib.optional withNiri pkgs.niri-stable;

  security.pam.services.greetd.fprintAuth = false;
}
