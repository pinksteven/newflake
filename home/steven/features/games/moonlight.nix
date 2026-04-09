{pkgs, ...}: {
  home = {
    packages = [pkgs.moonlight-qt];
    persistence."/persist" = {
      directories = [
        # TODO: persist needed dirs
      ];
    };
  };
}
