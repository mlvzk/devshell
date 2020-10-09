#!/usr/bin/env nix-build
# Used to test the shell
{ pkgs ? import ./. { } }:
let
  importTOML = file: {
    _file = file;
    config = builtins.fromTOML (builtins.readFile file);
  };
in
pkgs.mkDevShell {
  imports = [
    ./extensions/doctor.nix
    (importTOML ./devshell.toml)
  ];
}
