{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    prismlauncher
    steam
    gamescope
  ];
}
