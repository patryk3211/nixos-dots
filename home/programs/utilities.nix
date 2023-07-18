{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kalker
    gnome.file-roller
    gnome.nautilus
    btop
    vlc
    image-roll
    mate.atril
  ];
}
