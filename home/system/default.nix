{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    papirus-icon-theme
  ];

  home.pointerCursor = {
    name = "Catppuccin-Frappe-Light-Cursors";
    size = 16;
    package = pkgs.catppuccin-cursors.frappeLight;
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
