{pkgs, ...}: {
  home.packages = with pkgs; [
    calibre
  ];
  home.persistence."/persist/home/steven" = {
    directories = [
      ".config/calibre"
    ];
  };
}
