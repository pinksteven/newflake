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
            type = types.nullOr (types.submodule {
              options = {
                x = mkOption {
                  type = types.int;
                  default = 0;
                };
                y = mkOption {
                  type = types.int;
                  default = 0;
                };
              };
            });
            default = null;
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
          transform = {
            rotation = mkOption {
              type = types.enum [0 90 180 270];
              default = 0;
            };
            flipped = mkOption {
              type = types.bool;
              default = false;
            };
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
