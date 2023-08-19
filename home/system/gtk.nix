{ config, pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      package = config.theme.gtk.package;
      name = config.theme.gtk.name;
    };

    iconTheme = {
      name = config.theme.icon.name;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
