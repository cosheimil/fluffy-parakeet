{ config, pkgs, ... }: {
  home.stateVersion = "24.11";
  home.username = "artem";
  home.homeDirectory = "/home/artem";
  programs.home-manager.enable = true;

  imports = [
    ./git.nix
    ./ssh.nix
    ./hellix.nix
    ./picom.nix
    ./stylix.nix
    ./vscode.nix
    ./zellij.nix
    ./zsh.nix
    ./kitty.nix
    ./firefox.nix
    ./usr-pkgs.nix
    ./zathura.nix
    ./alacritty.nix
    ./feh.nix
    ./fastfetch.nix
  ];
}

