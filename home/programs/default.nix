{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    libreoffice
    krita
    webcord
    thunderbird
    neovim
    discord
  ];

  imports = [
    ./kitty.nix
    ./zsh.nix
    ./firefox.nix
    ./git.nix
    ./ssh-agent.nix
    ./keepass.nix
    ./3d.nix
    ./utilities.nix
#    ./nvim
  ];
}
