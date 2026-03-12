{pkgs, ...}: {
  home.packages = with pkgs; [
    dungeondraft
    wonderdraft
  ];

  home.persistence."/persist" = {
    directories = [
      ".local/share/Dungeondraft"
      ".local/share/Wonderdraft"
    ];
  };
}
