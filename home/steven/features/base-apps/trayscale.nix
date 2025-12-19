{pkgs, ...}: {
  home.packages = with pkgs; [trayscale];

  startupPrograms = [
    {
      delay = 7;
      command = ["trayscale" "--hide-window"];
    }
  ];
}
