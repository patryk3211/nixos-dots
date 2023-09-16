{ config, pkgs, ... }:

{
  home.packages = [ config.theme.qt.package ];

  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      name = "kvantum";
      package = pkgs.libsForQt5.qtstyleplugin-kvantum;
    };
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=${config.theme.qt.name}
  '';
}
