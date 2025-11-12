{pkgs, ...}: {
  home.packages = with pkgs; [
    loreforge
    dungeondraft
  ];

  home.persistence."/persist/home/steven" = {
    directories = [
      ".config/lore-forge"
      ".local/share/Dungeondraft"
    ];
  };
}
