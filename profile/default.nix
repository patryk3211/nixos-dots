{ lib, ... }:
with lib;
let
  monitor = {...}: {
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

      wallpaper = mkOption {
        type = types.nullOr types.str;
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

    wm.env = mkOption {
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

        MOZ_ENABLE_WAYLAND = "1";
      };
    };

    wm.monitors = mkOption {
      type = types.attrsOf (types.submodule monitor);
    };
  };
}
