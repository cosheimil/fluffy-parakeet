{ pkgs, ... }: {
  programs.helix = {
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
      language-server = { ruff = { command = "ruff-lsp"; }; };
      # language-server = { pylsp.config };

      language = [
        {
          name = "python";
          auto-format = true;
          language-servers = [ "pyright" "ruff" ];
          formatter.command = "${pkgs.ruff}/bin/ruff";
        }

        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";
          language-servers = [ "nil" ];
        }
      ];
    };

    extraPackages = with pkgs; [
      tinymist
      marksman
      ruff
      ruff-lsp
      pyright
      black
      nil
    ];
  };
}
