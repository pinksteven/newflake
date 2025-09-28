{pkgs, ...}: {
  home.packages = [pkgs.heroic];

  home.persistence."/persist/home/steven" = {
    # Persisit entire heroic dir (can't be bothered to seperate cache)
    directories = [".config/heroic"];
  };
}
