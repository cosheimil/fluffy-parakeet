{ ... }: {
  programs.git = {
    enable = true;
    userName = "Cosheimil";
    userEmail = "a.varvus@ya.ru";
    lfs.enable = true;

    extraConfig = { init = { defaultBranch = "main"; }; };
  };
}
