{ config, lib, ... }:
  with lib;
let
  cfg = config.patmods.colors;

  fg2 = if cfg.foreground2 == null then cfg.foreground else cfg.foreground2;
  fg3 = if cfg.foreground3 == null then fg2 else cfg.foreground3;
in {
  options.patmods.colors = {
    enable = mkEnableOption "Color scheme management";

    colors = mkOption {
      type = types.attrsOf types.str;
      default = {};
      description = ''
        Defines the base colors.
      '';
    };

    terminal = mkOption {
      type = types.attrsOf types.str;
      default = {};
      example = {};
      description = ''
        Defines the terminal colors.
      '';
    };

    eww = mkOption {
      type = types.attrsOf types.str;
      default = {};
      example = ''
        {
          foreground = "#ffffff";
          background = "#000000";
        }
      '';
      description = ''
        Colors put into eww/css/colors.scss file.
      '';
    };

    hypr = mkOption {
      type = types.attrsOf types.str;
      default = {};
      example = ''
        {
          border_active = "#ffffff";
          border_inactive = "#000000";
        }
      '';
      description = ''
        Defines colors used by hyprland.
      '';
    };

    dunst = mkOption {
      type = types.attrsOf types.str;
      default = {};
      description = ''
        Defines colors used by dunst.
      '';
    };
  };

  config = mkIf cfg.enable {
    xdg.configFile."eww/css/colors.scss".text = concatStrings (attrsets.mapAttrsToList(name: value: "\$${name}: ${value};\n") cfg.eww);
  };
}

