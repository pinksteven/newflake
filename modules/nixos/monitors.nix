# Taken from Misterio77/nix-config
{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.monitors = mkOption {
    type = types.listOf (
      types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            example = "DP-1";
          };
          primary = mkOption {
            type = types.bool;
            default = false;
          };
          width = mkOption {
            type = types.int;
            example = 1920;
          };
          height = mkOption {
            type = types.int;
            example = 1080;
          };
          refreshRate = mkOption {
            type = types.int;
            default = 60;
          };
          position = mkOption {
            type = types.str;
            default = "auto";
          };
          scale = mkOption {
            type = types.float;
            default = 1.0;
          };
          enabled = mkOption {
            type = types.bool;
            default = true;
          };
          workspace = mkOption {
            type = types.nullOr (types.listOf types.int);
            default = null;
          };
          transform = mkOption {
            type = types.int;
            default = 0;
            apply = v:
              if v < 0 || v > 7
              then throw "monitor.transform must be between 0 and 7 (got: ${toString v})"
              else v;
          };
          hdr = mkOption {
            type = types.bool;
            default = false;
          };
          vrr = mkOption {
            type = types.bool;
            default = false;
          };
        };
      }
    );
    default = [];
  };
  config = {
    assertions = [
      {
        assertion =
          ((lib.length config.monitors) != 0)
          -> ((lib.length (lib.filter (m: m.primary) config.monitors)) == 1);
        message = "Exactly one monitor must be set to primary.";
      }
    ];
  };
}
