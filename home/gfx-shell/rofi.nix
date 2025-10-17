{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    rofi
  ];

  xdg.configFile."rofi".source = ./rofi-config;

  /*programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    location = "center";
    terminal = "kitty";
    font = "FiraMono";
    extraConfig = {
      modi = "drun";
      modes = "drun";
      width = "40%";
      height = "40%";
    };
  };*/
}
