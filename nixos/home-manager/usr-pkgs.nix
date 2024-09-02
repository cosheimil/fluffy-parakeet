{ pkgs, ... }: {
  home.packages = with pkgs; [

    # (pkgs.python311.withPackages (python-pkgs: [
    #   python-pkgs.numpy
    #   python-pkgs.jupyter
    #   python-pkgs.matplotlib
    #   python-pkgs.sympy
    #   python-pkgs.scipy
    #   python-pkgs.pandas
    #   python-pkgs.shapely
    #   python-pkgs.faker
    # ]))
    poetry
    devenv

    # typst
    # typst-lsp
    texlive.combined.scheme-full
    texstudio

    pcmanfm
    # fastfetch
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
    noto-fonts-cjk-sans
    comic-mono
    comic-relief
    overpass
    (nerdfonts.override {
      fonts = [ "NerdFontsSymbolsOnly" "FantasqueSansMono" ];
    })

    (pkgs.discord.override {
      withVencord = true;
      withOpenASAR = true;
    })

    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans";
      fontSize = "9";
      background = "${/home/artem/wallpaper.jpg}";
      loginBackground = true;
    })
  ];
}

