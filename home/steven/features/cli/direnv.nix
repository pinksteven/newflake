{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.persistence."/persist/home/steven" = {
    directories = [".local/share/direnv"];
  };
}
