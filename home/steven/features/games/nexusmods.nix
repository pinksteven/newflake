{pkgs, ...}: {
  home = {
    packages = with pkgs; [nexusmods-app-unfree protontricks];
    persistence."/persist/home/steven" = {
      directories = [".local/share/NexusMods.App"];
    };
  };
}
