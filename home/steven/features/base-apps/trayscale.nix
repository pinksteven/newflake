{pkgs, ...}: {
  home.packages = with pkgs; [trayscale];

  startupPrograms = [
    {
      name = "trayscale";
      command = ["trayscale" "--hide-window"];
    }
  ];
}
