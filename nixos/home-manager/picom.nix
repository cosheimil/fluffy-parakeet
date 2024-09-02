{ config, ... }: {

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

  programs.rofi.enable = true;
}

