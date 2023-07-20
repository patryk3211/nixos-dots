{ pkgs, ... }:

{
  home.packages = with pkgs; [
    freecad
  ];

  imports = [
    ./cura.nix
  ];
}
