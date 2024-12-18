{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "strantalis";
  home.homeDirectory = "/Users/strantalis";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.nodejs_20
    pkgs.ory
    pkgs.air # go live reload

    # go tooling
    pkgs.gopls
    pkgs.delve
    pkgs.gomodifytags
    pkgs.impl
    pkgs.gotests
    pkgs.golangci-lint
    pkgs.templ

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/strantalis/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    antidote.enable = true;
    antidote.plugins = [
      "zsh-users/zsh-autosuggestions"
      "zsh-users/zsh-history-substring-search"
      "agkozak/zsh-z"
      "ohmyzsh/ohmyzsh path:lib/git.zsh"
      "ohmyzsh/ohmyzsh path:plugins/git" 
    ];
    history = {
      append = true;
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
    };
  };
  programs.starship = {
    enable = true;
  };
  programs.vscode = {
    enable = true;
    extensions = [
      pkgs.vscode-extensions.bbenoist.nix
      pkgs.vscode-extensions.golang.go
      pkgs.vscode-extensions.esbenp.prettier-vscode
      pkgs.vscode-extensions.ms-azuretools.vscode-docker
    ];
    userSettings = {
      "editor.formatOnSave" = true;
      "go.lintOnSave" = "workspace";
      "go.lintTool" = "golangci-lint";
      "go.lintFlags" = ["--fast"];
      "go.formatTool" = "gofumpt";
      "tailwindCSS.includeLanguages" = {
        "templ" = "html";
      };
      "terminal.external.osxExec" = "iTerm.app";
      "terminal.integrated.shell.osx" = "/etc/profiles/per-user/strantalis/bin/zsh";
      "terminal.integrated.fontFamily" = "FiraCode Nerd Font Mono";
    };
  };
  programs.git = {
    enable = true;
    difftastic.enable = true;
    maintenance.enable = true;
    userEmail = "stran58@gmail.com";
    userName = "strantalis";
    extraConfig = {
      commit = {
        gpgsign = true;
      };
      gpg = {
        format = "ssh";
      };
      user = {
        signingkey = "~/.ssh/git_signing_ed25519";
      };
    };
  };
  programs.go = {
    enable = true;
    goPath = "go";
    goBin = ".local";
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
}
