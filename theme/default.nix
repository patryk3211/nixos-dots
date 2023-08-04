{ pkgs, lib, ... }: {
  options = {
    theme = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      readOnly = true;
    };
  };

  config.theme = {
    icon = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    gtk = {
      package = pkgs.catppuccin-gtk;
      name = "Catppuccin-Frappe-Standard-Blue-dark";
    };

    qt = {
      package = pkgs.catppuccin-kvantum;
      name = "Catppuccin-Frappe-Blue";
    };

    cursor = {
      package = pkgs.catppuccin-cursors.frappeLight;
      name = "Catppuccin-Frappe-Light-Cursors";
    };
  };
}
