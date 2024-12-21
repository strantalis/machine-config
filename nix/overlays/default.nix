# ./overlays/default.nix
{ pkgs, lib, inputs, ...}:

{
   # Pin Karabiner https://github.com/LnL7/nix-darwin/issues/1041
    nixpkgs.overlays = [
      (import ./delve.nix)
      (import ./ory.nix)
      inputs.nix-vscode-extensions.overlays.default
    ];
}
