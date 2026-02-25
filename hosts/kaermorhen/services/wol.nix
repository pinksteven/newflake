{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wakeonlan
  ];
}
