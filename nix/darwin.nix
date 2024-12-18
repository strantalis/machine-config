# darwin.nix

{ config, pkgs, ... }:

{
    nix.optimise.automatic = true;
  
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = [ 
      pkgs.vim 
      pkgs.colima
      pkgs.docker-client
      pkgs.spotify
    ];
    environment.pathsToLink = [
      "/share/zsh"
    ];
    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;
    services.karabiner-elements.enable = false;
    # nix.package = pkgs.nix;

    # Create /etc/zshrc that loads the nix-darwin environment.
    #programs.zsh.enable = true;  # default shell on catalina
    # programs.fish.enable = true;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 5;    

    # Necessary for using flakes on this system.
    nix.settings.experimental-features = "nix-command flakes";

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";
    nixpkgs.config.allowUnfree = true;
        
 
    users.users.strantalis = {
        name = "strantalis";
        home = "/Users/strantalis";
    };
   
    fonts.packages = with pkgs; [
      nerd-fonts.fira-code
    ];

    system.defaults = {
      dock.autohide = true;
      dock.persistent-apps = [
        "/Applications/System\ Settings.app"
        "/Applications/NVIDIA\ GeForce\ Now.app"
        "/Applications/Nix\ Apps/Spotify.app"
        "/Applications/Signal.app"
        "/Applications/Bitwarden.app"
        "/Applications/Firefox.app"
        "/Applications/iTerm.app"
        "~/Applications/Home\ Manager\ Apps/Visual\ Studio\ Code.app"
      ];
      finder.AppleShowAllFiles = true;
      finder.FXPreferredViewStyle = "Nlsv";
      finder.ShowPathbar = true;
      NSGlobalDomain.AppleInterfaceStyle = "Dark";
    };
}
