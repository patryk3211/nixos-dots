{ config, nvim, pkgs, ... }:

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
    betterbird
    dolphin
    nvim.packages.x86_64-linux.default
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
