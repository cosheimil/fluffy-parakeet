{ ... }: {
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableCompletion = true;
    history.path = "$HOME/.hf";
    history.save = 10000;
    history.size = 10000;
    history.share = true;
    history.extended = true;
    history.ignoreSpace = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    initExtra = "krabby random --no-mega --no-gmax --no-regional";
  };

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };
}
