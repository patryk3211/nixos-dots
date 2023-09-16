{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    config.theme.icon.package

    udiskie
  ];

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

  services.udiskie = {
    enable = true;
    notify = true;
    settings = {
      program_options = {
        udisks_version = 2;
      };
    };
  };

  imports = [
    ./gtk.nix
    ./xdg.nix
    ./qt.nix
  ];
}
