{ config, pkgs, ... }:
let
  username = "strantalis";
  homeDirectory = "/Users/strantalis";
  gitUserEmail = "stran58@gmail.com";
  gitSigningPubKey = ''
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID+nfA2fOvNdSPddKrKCj+3OFUImFDc8s3wcOpPTMXzW stran58@gmail.com
  '';
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = username;
    homeDirectory = homeDirectory;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.11"; # Please read the comment before changing.

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      ".ssh/allowed_signers".text = ''
        ${gitUserEmail} ${gitSigningPubKey}
      '';
    };

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      nodejs_20
      ory
      air # go live reload

      # go tooling
      gopls
      delve
      gomodifytags
      impl
      gotests
      golangci-lint
      templ

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
    sessionVariables = {
      EDITOR = "code";
      SSH_AUTH_SOCK = "${homeDirectory}/.bitwarden-ssh-agent.sock";
    };
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        darwsw = "darwin-rebuild switch --flake ~/.config/nix#mac-mini";
        nixup = "nix flake update --refresh --flake ~/.config/nix";
        nixdiff = "nix profile diff-closures --profile ~/.config/nix";
      };
      antidote.enable = true;
      antidote.plugins = [
        # Import all libs
        "ohmyzsh/ohmyzsh path:lib"

        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-syntax-highlighting"
        "agkozak/zsh-z"
        "ohmyzsh/ohmyzsh path:plugins/git"
        "ohmyzsh/ohmyzsh path:plugins/gh"
        "ohmyzsh/ohmyzsh path:plugins/docker"
        "ohmyzsh/ohmyzsh path:plugins/fzf"
        "ohmyzsh/ohmyzsh path:plugins/golang"
        "MichaelAquilina/zsh-you-should-use"
        "ohmyzsh/ohmyzsh path:plugins/kubectl"
        "ohmyzsh/ohmyzsh path:plugins/kubectx"
        "ohmyzsh/ohmyzsh path:plugins/helm"
        "ohmyzsh/ohmyzsh path:plugins/colored-man-pages"
        "fdellwing/zsh-bat"
      ];
      history = {
        append = true;
        expireDuplicatesFirst = true;
        ignoreAllDups = true;
        ignoreDups = true;
        ignoreSpace = true;
      };
      historySubstringSearch = {
        enable = true;
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hiddent --follow --no-ignore-vcs";
    };

    starship = {
      enable = true;
    };

    vscode = {
      enable = true;
      enableExtensionUpdateCheck = false;
      mutableExtensionsDir = false;
      extensions =
        with pkgs.vscode-marketplace;
        with pkgs.vscode-marketplace-release;
        [
          bbenoist.nix
          golang.go
          esbenp.prettier-vscode
          ms-azuretools.vscode-docker
          github.copilot
          github.copilot-chat
          bradlc.vscode-tailwindcss
          a-h.templ
          vincaslt.highlight-matching-tag
          aaron-bond.better-comments
          alefragnani.bookmarks
          robertz.code-snapshot
          mkhl.direnv
          oderwat.indent-rainbow
          bierner.markdown-mermaid
          jnoortheen.nix-ide
          arrterian.nix-env-selector
          inferrinizzard.prettier-sql-vscode
          foxundermoon.shell-format
          wayou.vscode-todo-highlight
          vscode-icons-team.vscode-icons
          redhat.vscode-yaml
          usernamehw.errorlens
          eamodio.gitlens
        ];
      userSettings = {
        "editor.formatOnSave" = true;
        "go.lintOnSave" = "workspace";
        "go.lintTool" = "golangci-lint";
        "go.lintFlags" = [ "--fast" ];
        "go.formatTool" = "gofumpt";
        "go.alternateTools" = {
          "dlv" = "/etc/profiles/per-user/strantalis/bin/dlv";
        };
        "tailwindCSS.includeLanguages" = {
          "templ" = "html";
        };
        "terminal.external.osxExec" = "Ghostty.app";
        "terminal.integrated.shell.osx" = "/etc/profiles/per-user/strantalis/bin/zsh";
        "terminal.integrated.fontFamily" = "FiraCode Nerd Font Mono";
        "[json]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[jsonc]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
      };
    };

    git = {
      enable = true;
      difftastic.enable = true;
      maintenance.enable = true;
      userEmail = gitUserEmail;
      userName = "strantalis";
      signing = {
        format = "ssh";
        signByDefault = true;
        key = gitSigningPubKey;
      };
      extraConfig = {
        url = {
          "git@github.com:" = {
            insteadOf = "https://github.com/";
          };
          init = {
            defaultBranch = "main";
          };
          diff = {
            colorMoved = "default";
          };
        };
        core = {
          editor = "code --wait";
        };
        commit = {
          gpgsign = true;
        };
        gpg = {
          ssh = {
            allowedSignersFile = "${homeDirectory}/.ssh/allowed_signers";
          };
        };
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
    };

    go = {
      enable = true;
      goPath = "go";
      goBin = ".local";
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };

    kubecolor = {
      enable = true;
    };
  };

}
