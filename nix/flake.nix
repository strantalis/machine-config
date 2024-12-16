{
  description = "Seans nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05"; 
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, home-manager,  nix-darwin, mac-app-util, nixpkgs, nixpkgs-stable }: 
  let
    # Set Git commit hash for darwin-version.
    system.configurationRevision = self.rev or self.dirtyRev or null;
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Seans-Mac-mini
    darwinConfigurations."Seans-Mac-mini" = nix-darwin.lib.darwinSystem {
      modules = [ 
        ./darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # To enable it for all users:
          home-manager.sharedModules = [
            mac-app-util.homeManagerModules.default
          ];
          home-manager.users.strantalis = import ./home.nix;
        }
        (import ./overlays)
      ];
    };
  };
}