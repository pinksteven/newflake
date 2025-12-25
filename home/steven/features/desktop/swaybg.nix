{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.swaybg];

  systemd.user.services.swaybg = {
    Unit = {
      Description = "Set background image using swaybg";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
      Requisite = [config.wayland.systemd.target];
    };
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i ${config.stylix.image}";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [config.wayland.systemd.target];
    };
  };
}
