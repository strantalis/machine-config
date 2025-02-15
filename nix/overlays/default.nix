# ./overlays/default.nix
{
  pkgs,
  lib,
  inputs,
  ...
}:

{
  nixpkgs.overlays = [
    (import ./delve.nix)
    (import ./ory.nix)
    inputs.nix-vscode-extensions.overlays.default
  ];
}
