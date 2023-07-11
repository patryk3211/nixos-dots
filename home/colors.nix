{ config, lib, ... }:
let
  colors = config.patmods.colors.colors;
in {
  patmods.colors = {
    enable = true;

    # Colors taken from `https://github.com/catppuccin/catppuccin`, Frappe theme
    colors = {
      rosewater = "F2D5CF";
      flamingo = "EEBEBE";
      pink = "F4B8E4";
      mauve = "CA9EE6";
      red = "E78284";
      maroon = "EA999C";
      peach = "EF9F76";
      yellow = "E5C890";
      green = "A6D189";
      teal = "81C8BE";
      sky = "99D1DB";
      sapphire = "85C1DC";
      blue = "8CAAEE";
      lavender = "BABBF1";

      text = "C6D0F5";
      subtext1 = "B5BFE2";
      subtext0 = "A5ADCE";

      overlay2 = "949CBB";
      overlay1 = "838BA7";
      overlay0 = "737994";

      surface2 = "626880";
      surface1 = "51576d";
      surface0 = "414559";

      base = "303446";
      mantle = "292c3c";
      crust = "232634";
    };

    # Terminal theme from `https://github.com/catppuccin/kitty/blob/main/themes/frappe.conf`
    terminal = {
      foreground = "#C6D0F5";
      background = "#303446";
      selection_foreground = "#303446";
      selection_background = "#F2D5CF";

      cursor = "#F2D5CF";
      cursor_text_color = "#303446";

      url_color = "#F2D5CF";

      active_border_color = "#BABBF1";
      inactive_border_color = "#737994";
      bell_border_color = "#E5C890";

      wayland_titlebar_color = "system";

      active_tab_foreground = "#232634";
      active_tab_background = "#CA9EE6";
      inactive_tab_foreground = "#C6D0F5";
      inactive_tab_background = "#292C3C";
      tab_bar_background = "#232634";

      mark1_foreground = "#303446";
      mark1_background = "#BABBF1";
      mark2_foreground = "#303446";
      mark2_background = "#CA9EE6";
      mark3_foreground = "#303446";
      mark3_background = "#85C1DC";

      color0 = "#51576D";
      color8 = "#626880";

      color1 = "#E78284";
      color9 = "#E78284";

      color2 = "#A6D189";
      color10 = "#A6D189";

      color3 = "#E5C890";
      color11 = "#E5C890";

      color4 = "#8CAAEE";
      color12 = "#8CAAEE";

      color5 = "#F4B8E4";
      color13 = "#F4B8E4";

      color6 = "#81C8BE";
      color14 = "#81C8BE";

      color7 = "#B5BFE2";
      color15 = "#A5ADCE";
    };

    eww = {
    } // lib.attrsets.mapAttrs (name: value: "#${value}") colors;

    hypr = {
      border_active = colors.lavender;
      border_inactive = colors.overlay0;
    };

    dunst = {
      background = "#" + colors.base;
      foreground = "#" + colors.text;
      low = "#" + colors.surface1;
      normal = "#" + colors.blue;
      urgent = "#" + colors.red;
    };
  };
}
