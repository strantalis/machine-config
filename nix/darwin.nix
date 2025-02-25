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
    pkgs.darwin.xcode_16_1
    pkgs.mkcert
    pkgs.ollama
    pkgs.nixfmt-rfc-style
  ];
  environment.pathsToLink = [
    "/share/zsh"
  ];
  # Auto upgrade nix package and the daemon service.
  nix.enable = true;

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
      "/System/Applications/System Settings.app"
      "/Applications/GeForceNOW.app"
      "/Applications/Steam.app"
      "/Applications/Nix\ Apps/Spotify.app"
      "/Applications/Signal.app"
      "/Applications/Discord.app"
      "/Applications/Bitwarden.app"
      "/Applications/Ghostty.app"
      "/Applications/Firefox.app"
      "/Users/strantalis/Applications/Home Manager Apps/Visual Studio Code.app"
      "/Applications/BambuStudio.app"
    ];
    finder.AppleShowAllFiles = true;
    finder.FXPreferredViewStyle = "Nlsv";
    finder.ShowPathbar = true;
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
  };

  environment.etc."hosts" = {
    text = ''
      ##
      # Host Database
      #
      # localhost is used to configure the loopback interface
      # when the system is booting.  Do not change this entry.
      ##
      127.0.0.1       localhost
      255.255.255.255 broadcasthost
      ::1             localhost

      # Addtional
      127.0.0.1 app.local
      127.0.0.1 static.app.local
      127.0.0.1 console.app.local
      127.0.0.1 login.app.local
      127.0.0.1 register.app.local
      127.0.0.1 auth.app.local
    '';
  };
}
