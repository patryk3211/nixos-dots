{ options, config, pkgs, ... }:

{
  profile = {
    hyprland = {
      env = options.profile.hyprland.env.default // {
        LIBVA_DRIVER_NAME = "nvidia";
        GBM_SESSION_TYPE = "nvidia-drm";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        WLR_NO_HARDWARE_CURSORS = "1";
      };

      monitors = {
        "HDMI-A-1" = {
          resolution = "1920x1080";
          framerate = "60";
          position = "0x0";
          scale = "1";
        };
      };
    };
  };
}
