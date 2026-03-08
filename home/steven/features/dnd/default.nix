{pkgs, ...}: {
  home.packages = with pkgs; [
    dungeondraft
    wonderdraft
  ];

  home.persistence."/persist" = {
    directories = [
      ".config/lore-forge"
      ".local/share/Dungeondraft"
      ".local/share/Wonderdraft"
    ];
  };
}
