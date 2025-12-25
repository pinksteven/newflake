{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./global

    ./features/stylix
    ./features/desktop
    ./features/base-apps
    ./features/games
    ./features/dnd
    ./features/zed
  ];

  home = {
    packages = with pkgs; [piper];
    sessionVariables = {
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      MOZ_DISABLE_RDD_SANDBOX = 1;
    };
  };

  wallpaper = "${inputs.wallpapers}/" + "green-girl.jpg";

  fontProfiles = {
    monospace = {
      name = "FiraCode Nerd Font";
      package = pkgs.nerd-fonts.fira-code;
    };
    sansSerif = {
      name = "CodeNewRoman Nerd Font";
      package = pkgs.nerd-fonts.code-new-roman;
    };
    serif = {
      name = "CodeNewRoman Nerd Font";
      package = pkgs.nerd-fonts.code-new-roman;
    };
    emoji = {
      name = "Noto Color Emoji";
      package = pkgs.noto-fonts-color-emoji;
    };
    sizes = {
      applications = 12;
      desktop = 12;
      popups = 12;
      terminal = 12;
    };
  };
}
