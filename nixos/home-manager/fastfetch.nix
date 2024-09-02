{ ... }: {
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "nixos_small";
        padding = { right = 1; };
      };
      display = {
        size.binaryPrefix = "si";
        color = "blue";
        separator = "  ";
      };
      modules = [
        {
          type = "title";
          key = "󰧨 Host";
          keyWidth = 10;
        }

        {
          type = "os";
          key = "{icon} OS";
        }

        {
          type = "cpu";
          key = "┌ ┐󰻠";
        }

        {
          type = "gpu";
          key = "│ ├󰍛";
        }

        {
          type = "disk";
          key = "│ ├";
        }

        {
          type = "memory";
          key = "│ ├󰑭";
        }

        {
          type = "swap";
          key = "└ ┘󰓡";
        }
      ];
    };
  };
}
