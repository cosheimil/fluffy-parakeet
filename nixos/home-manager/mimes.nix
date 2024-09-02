{ ... }: {
  xdg.mime.enable = true;
  xdg.mimeAps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
      "text/html" = [ "firefox.desktop" ];
      "application/pdf" =
        [ "zathura.desktop" "evince.desktop" "firefox.desktop" ];
    };
  };
}
