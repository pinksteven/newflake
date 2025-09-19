{
  config,
  lib,
  pkgs,
  ...
}: let
  theme = ''border=blue;text=yellow;prompt=green;action=cyan;button=magenta;container=black;input=white'';
  settings = "-r --asterisks --asterisks-char • --window-padding 1 -t
              --time-format '%H:%M | %a  %d %b %Y' -g 'Welcome back!' --remember-user-session";
in {
  users.extraUsers.greeter = {
    # For caching and such
    home = "/tmp/greeter-home";
    createHome = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.tuigreet} ${settings} --theme '${theme}'";
        user = config.users.extraUsers.greeter.name;
      };
    };
  };

  security.pam.services.greetd.fprintAuth = false;
}
