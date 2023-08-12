{ config, pkgs, ... }: {
  services.dunst = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    settings = {
      global = {
        width = 480;
        height = 240;
        offset = "10x10";
        origin = "top-right";
        transparency = 20;
        frame_width = 2;
        gap_size = 4;
        font = "Noto Sans 11";
        min_icon_size = 64;
        max_icon_size = 128;

        background = config.patmods.colors.dunst.background;
        foreground = config.patmods.colors.dunst.foreground;
      };

      urgency_low = {
        frame_color = config.patmods.colors.dunst.low;
        timeout = 5;
      };

      urgency_normal = {
        frame_color = config.patmods.colors.dunst.normal;
        timeout = 5;
      };

      urgency_critical = {
        frame_color = config.patmods.colors.dunst.urgent;
      };
    };
  };
}
