{ lib, ... }:
with lib;
let
  hyprlandMonitor = {...}: {
    options = {
      resolution = mkOption {
        type = types.str;
      };
      framerate = mkOption {
        type = types.str;
      };
      position = mkOption {
        type = types.str;
      };
      scale = mkOption {
        type = types.str;
      };
    };
  };
in {
  options.profile = {
    username = mkOption {
      type = types.str;
    };

    hostname = mkOption {
      type = types.str;
    };

    homeDirectory = mkOption {
      type = types.str;
    };

    hyprland.env = mkOption {
      type = types.attrsOf types.str;
      default = {
        _JAVA_AWT_WM_NONREPARENTING = "1";
        GDK_BACKEND = "wayland,x11";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";

        XDG_CURRENT_DESKTOP = "Hyprland";
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "Hyprland";

        QT_QPA_PLATFORM = "wayland;xcb";
        QT_AUTO_SCREEN_SCALE_FACTOR = "1";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        QT_QPA_PLATFORMTHEME = "qt5ct";
      };
    };

    hyprland.monitors = mkOption {
      type = types.attrsOf (types.submodule hyprlandMonitor);
    };
  };
}
