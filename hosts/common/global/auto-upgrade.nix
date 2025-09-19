{inputs, ...}: {
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    flake = "~/Documents/newflake";
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
    ];
    allowReboot = false;
  };
}
