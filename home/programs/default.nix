{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    vlc
    image-roll
    libreoffice
    btop
    mate.atril
    kalker
    gnome.file-roller
    krita
  ];

  imports = [
    ./kitty.nix
    ./zsh.nix
    ./firefox.nix
    ./nnn.nix
    ./git.nix
    ./ssh-agent.nix
    ./keepass.nix
#    ./nvim
  ];
}
