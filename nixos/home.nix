{ config, pkgs, ... }:

{
  home.username = "artem";
  home.homeDirectory = "/home/artem";
  home.stateVersion = "23.11";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    (pkgs.python311.withPackages (python-pkgs: [
      python-pkgs.numpy
      python-pkgs.jupyter
      python-pkgs.matplotlib
      python-pkgs.sympy
      python-pkgs.scipy
      python-pkgs.pandas
      python-pkgs.shapely
      python-pkgs.faker
    ]))
    poetry
    devenv

    typst
    typst-lsp
    texlive.combined.scheme-full
    texstudio

    firefox
    pcmanfm
    fastfetch
    syncthing
    pavucontrol
    gimp
    btop
    x2goclient
    xournalpp
    onlyoffice-bin
    obsidian
    flameshot
    okular
    super-productivity
    nitrogen
    mictray
    qbittorrent
    vlc
    mattermost-desktop
    zed-editor
    safeeyes
    krabby

    xclip
    networkmanagerapplet

    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    openmoji-color
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override {
      fonts = [ "NerdFontsSymbolsOnly" "FantasqueSansMono" ];
    })

    (pkgs.discord.override {
      withVencord = true;
      withOpenASAR = true;
    })
  ];

  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   package = pkgs.hyprland;
  #   xwayland.enable = true;
  #   systemd.enable = true;
  # };

  fonts.fontconfig.enable = true;
  fonts.fontconfig = { defaultFonts = { emoji = [ "OpenMoji Color" ]; }; };

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;

    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  programs = {
    helix = {
      enable = true;
      defaultEditor = true;

      settings = {
        editor = {
          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };

          line-number = "relative";
          lsp.display-messages = true;
        };
      };

      languages = {
        language-server = { ruff = { command = "ruff"; }; };

        language = [
          {
            name = "python";
            language-servers = [ "ruff" ];
            auto-format = true;
          }

          {
            name = "nix";
            auto-format = true;
            formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";
          }
        ];
      };

      extraPackages = with pkgs; [ marksman ruff ruff-lsp ];
    };

    yazi = {
      enable = true;
      enableZshIntegration = true;
    };

    zellij = {
      enable = true;
      enableZshIntegration = true;
    };

    zathura = { enable = true; };

    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [ bbenoist.nix ];
      userSettings = {
        "files.autoSave" = "afterDelay";
        "[nix]"."editor.tabSize" = 2;
        "python.linting.enabled" = "true";
      };
    };

    # alacritty = { enable = true; };
    kitty = { enable = true; };

    rofi.enable = true;

    git = {
      enable = true;
      userName = "Cosheimil";
      userEmail = "a.varvus@ya.ru";
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      initExtra = "krabby random --no-mega --no-gmax --no-regional";
    };
  };

  services.picom = {
    enable = true;
    vSync = true;
    shadow = true;
    backend = "glx";
    activeOpacity = 0.9;
    wintypes = {
      popup_menu = { opacity = config.services.picom.menuOpacity; };
      dropdown_menu = { opacity = config.services.picom.menuOpacity; };
    };
    fade = true;
    fadeDelta = 4;
    settings = {
      blur = {
        method = "dual_kawase";
        strength = 8;
        background = true;
      };
      corner-radius = 5;
    };
  };

  home.sessionVariables = {
    EDITOR = "hx";
    # LD_LIBRARY_PATH=''${pkgs.lib.makeLibraryPath [
    #   pkgs.stdenv.cc.cc
    # ]}'';
  };

  stylix.enable = true;
  # stylix.base16Scheme = {
  #   base00 = "1F1F28";
  #   base01 = "2A2A37";
  #   base02 = "223249";
  #   base03 = "727169";
  #   base04 = "C8C093";
  #   base05 = "DCD7BA";
  #   base06 = "938AA9";
  #   base07 = "363646";
  #   base08 = "C34043";
  #   base09 = "FFA066";
  #   base0A = "DCA561";
  #   base0B = "98BB6C";
  #   base0C = "7FB4CA";
  #   base0D = "7E9CD8";
  #   base0E = "957FB8";
  #   base0F = "D27E99";
  # };
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";

  stylix.image = /home/artem/wallpaper.jpg;

  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Ice";
  stylix.cursor.size = 18;

  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
      name = "JetBrainsMono Nerd Font Mono";
    };
    sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };
    serif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Serif";
    };
    sizes = { terminal = 10; };
  };

  stylix.polarity = "dark";
  programs.home-manager.enable = true;
}
