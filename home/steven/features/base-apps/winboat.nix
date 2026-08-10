{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      winboat
    ];

    persistence."/persist" = {
      directories = [
        ".config/winboat"
        ".local/share/winboat"
      ];
    };
  };
}
