{pkgs, ...}: {
  home.packages = with pkgs; [
    loreforge
    dungeondraft
    maptool
  ];

  home.persistence."/persist/home/steven" = {
    directories = [
      ".config/lore-forge"
      ".local/share/Dungeondraft"
      ".maptool"
    ];
  };
}
