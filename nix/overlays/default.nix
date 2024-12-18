# ./overlays/default.nix
{ config, pkgs, lib, inputs, ...}:

{
   # Pin Karabiner https://github.com/LnL7/nix-darwin/issues/1041
    nixpkgs.overlays = [
      (import ./ory.nix)
    ];
}
