{lib, ...}: let
  inherit (lib) types mkOption;
in {
  options.gamingReady = mkOption {
    type = types.bool;
    default = false;
    description = "A flag to mark system as setup for games";
  };
}
