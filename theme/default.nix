{ config, pkgs, lib, ... }: {
  options = {
    theme = lib.mkOption {
      type = lib.types.attrsOf lib.types.anything;
      readOnly = true;
    };
  };

  config.theme = {
    icon = {
    #  package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    gtk = {
      package = pkgs.catppuccin-gtk.override {
        accents = [ config.catppuccin.accent ];
        size = "standard";
        tweaks = [ "float" ];
        variant = config.catppuccin.flavor;
      };
      name = "catppuccin-${config.catppuccin.flavor}-${config.catppuccin.accent}-standard+float";
    };

    # qt = {
    #   package = pkgs.catppuccin-kvantum;
    #   name = "Catppuccin-Frappe-Blue";
    # };

    cursor = {
      package = pkgs.catppuccin-cursors.frappeBlue;
      name = "catppuccin-frappe-blue-cursors";
    };
  };
}

