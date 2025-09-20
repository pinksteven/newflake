{pkgs, ...}: {
  home.packages = with pkgs; [
    loreforge
    dungeondraft
  ];

  home.persistence."/persist" = {
    directories = [
      ".config/lore-forge"
      ".local/share/Dungeondraft"
    ];
  };
}
