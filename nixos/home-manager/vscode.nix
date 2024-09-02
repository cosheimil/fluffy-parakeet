{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      # nvarner.typst-lsp
      tomoki1207.pdf
    ];
    userSettings = {
      "files.autoSave" = "afterDelay";
      "[nix]"."editor.tabSize" = 2;
      "python.linting.enabled" = "true";
    };
  };
}

