{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.doctor;

  toCheckScript = { name, help, test }:
    pkgs.writeShellScript "doctor-check-${name}" ''
      (
        ${test}
      )
      if [[ $? -ne 0 ]]; then
        echo "${name}: Doctor check failed"
        echo "${help}"
        exit 1
      else
        echo "${name}: OK"
      fi
    '';

  doctor = pkgs.writeShellScriptBin "doctor" ''
    set -euo pipefail

    for check in ${toString (map toCheckScript cfg.checks)}; do
      "$check"
    done

    echo "All healthy!"
  '';

  checkOptions = {
    name = mkOption {
      type = types.str;
      description = ''
        Name of the check.
      '';
    };

    help = mkOption {
      type = types.str;
      default = "";
      description = ''
        Describes the resolution if the script fails.
      '';
    };

    test = mkOption {
      type = types.str;
      description = ''
        A command to run, to do the check.
      '';
    };
  };
in
{
  options = {
    doctor = {
      enable = mkEnableOption "enable the doctor";

      checks = mkOption {
        type = types.listOf (types.submodule { options = checkOptions; });
        default = [ ];
        description = ''
          Add checks to the environment.
        '';
        example = literalExample ''
          [
          ]
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    commands = [
      {
        name = "doctor";
        help = "Checks that the environment is in a healthy state";
        package = doctor;
      }
    ];

    bash.interactive = ''
      doctor
    '';
  };
}
