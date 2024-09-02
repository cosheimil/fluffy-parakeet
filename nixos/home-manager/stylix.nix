{ pkgs, ... }: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    # base16Scheme =
    # "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    # base16Scheme = {
    #   base00 = "1f1f28";
    #   base01 = "2a2a37";
    #   base02 = "223249";
    #   base03 = "727169";
    #   base04 = "c8c093";
    #   base05 = "dcd7ba";
    #   base06 = "938aa9";
    #   base07 = "363646";
    #   base08 = "c34043";
    #   base09 = "ffa066";
    #   base0A = "dca561";
    #   base0B = "98bb6c";
    #   base0C = "7fb4ca";
    #   base0D = "7e9cd8";
    #   base0E = "957fb8";
    #   base0F = "d27e99";
    # };

    image = /home/artem/wallpaper.jpg;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 18;
    };

    fonts = {
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
    polarity = "dark";
  };
}
