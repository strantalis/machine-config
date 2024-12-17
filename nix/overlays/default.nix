# ./overlays/default.nix
{ config, pkgs, lib, inputs, ...}:

{
   # Pin Karabiner https://github.com/LnL7/nix-darwin/issues/1041
    nixpkgs.overlays = [
      (_: prev: {
        # https://github.com/LnL7/nix-darwin/issues/1041
        inherit (inputs.nixpkgs-stable.legacyPackages.${prev.system}) karabiner-elements;
      })
      (import ./ory.nix)
    ];
}
