{ config, pkgs, ... }:

{
  home.packages = [ config.theme.icon.package ];

  home.pointerCursor = {
    name = config.theme.cursor.name;
    size = 16;
    package = config.theme.cursor.package;
    gtk.enable = true;
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  imports = [
    ./gtk.nix
    ./xdg.nix
    ./qt.nix
  ];
}
