{pkgs, ...}: {
  home = {
    packages = with pkgs; [nexusmods-app-unfree];
    persistence."/persist/home/steven" = {
      directories = [".local/share/NexusMods.App"];
    };
  };
}
