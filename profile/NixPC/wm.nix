{ options, config, ... }:

{
  profile = {
    wm = {
      env = options.profile.wm.env.default // {
        LIBVA_DRIVER_NAME = "nvidia";
        GBM_SESSION_TYPE = "nvidia-drm";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        __GL_VRR_ALLOWED = "1";
        WLR_NO_HARDWARE_CURSORS = "1";
        WLR_DRM_NO_ATOMIC = "1";
        SDL_VIDEODRIVER = "x11";
        GALLIUM_DRIVER = "nvidia";
      };

      monitors = {
        "HDMI-A-1" = {
          resolution = "1920x1080";
          framerate = "60";
          position = "0x0";
          scale = "1";
          wallpaper = "${config.home.homeDirectory}/.config/hypr/wallpaper.jpg";
        };
      };
    };
  };
}

