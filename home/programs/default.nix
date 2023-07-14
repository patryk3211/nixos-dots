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
    webcord
    thunderbird
    neovim
    #nvim.packages.x86_64-linux.default
    gnome.nautilus
  ];

  imports = [
    ./kitty.nix
    ./zsh.nix
    ./firefox.nix
    ./git.nix
    ./ssh-agent.nix
    ./keepass.nix
#    ./nvim
  ];
}
