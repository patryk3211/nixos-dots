{ config, ... }: {
  services.dunst = {
    enable = true;

    settings = {
      global = {
        width = 320;
        height = 240;
        offset = "10x10";
        origin = "top-right";
        transparency = 20;
        frame_width = 2;
	gap_size = 4;

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
