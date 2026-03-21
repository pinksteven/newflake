{
  programs.obsidian = {
    enable = true;
    vaults = {
      uni = {
        target = "Documents/.obsidian/uni";
      };
      victorian = {
        target = "Documents/.obsidian/victorian";
      };
    };
  };
  stylix.targets.obsidian = {
    enable = true;
    colors.enable = true;
    fonts.enable = true;
    vaultNames = ["uni" "victorian"];
  };
  home.persistence."/persist" = {
    directories = [".config/obsidian"];
  };
}
