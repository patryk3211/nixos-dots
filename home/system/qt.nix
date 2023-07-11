{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    catppuccin-kvantum
  ];

  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      name = "kvantum";
      package = pkgs.libsForQt5.qtstyleplugin-kvantum;
    };
  };
}
