#!/usr/bin/env nix-build
# Used to test the shell
{ pkgs ? import ./. { } }:
pkgs.mkDevShell {
  imports = [
    ./extensions/doctor.nix
    (pkgs.lib.modules.fromTOML ./devshell.toml)
  ];
}
