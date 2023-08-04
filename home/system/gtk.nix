{ config, pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      package = config.theme.gtk.package;
      name = config.theme.gtk.name;
      #package = pkgs.catppuccin-gtk;
      #name = "Catppuccin-Frappe-Standard-Blue-dark";
    };

    iconTheme = {
      name = config.theme.icon.name;
      #name = "Papirus-Dark";
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
