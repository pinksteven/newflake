{pkgs, ...}: {
  home = {
    packages = with pkgs; [nexusmods-app-unfree];
    persistence."/persist" = {
      directories = [".local/share/NexusMods.App"];
    };
  };
}
