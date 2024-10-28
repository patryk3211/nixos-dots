{ config, lib, pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      ignore-empty-password = true;
      screenshots = true;
      indicator = true;
      clock = true;
      disable-caps-lock-text = true;

      font = "FiraMono Nerd Font";
      font-size = 120;
      # Hijack the clock text to display a lock icon
      timestr = "";
      datestr = "";

      fade-in = 0.2;
      effect-blur = "20x2";
      effect-scale = 0.3;

      indicator-radius = 120;
      indicator-thickness = 10;

      # key-hl-color    = "a6d189";
      # bs-hl-color     = "e78284";
      # separator-color = "303446";

      # inside-color           = "23263480";
      # inside-clear-color     = "23263480";
      # inside-caps-lock-color = "23263480";
      # inside-ver-color       = "23263480";
      # inside-wrong-color     = "23263480";

      # ring-color             = "babbf1";
      # ring-clear-color       = "c6d0f5";
      # ring-caps-lock-color   = "e5c890";
      # ring-ver-color         = "81c8be";
      # ring-wrong-color       = "e78284";

      # text-color             = "babbf1";
      # text-clear-color       = "00000000";
      # text-caps-lock-color   = "00000000";
      # text-ver-color         = "00000000";
      # text-wrong-color       = "00000000";

      # line-color             = "303446";
      # line-clear-color       = "303446";
      # line-caps-lock-color   = "303446";
      # line-ver-color         = "303446";
      # line-wrong-color       = "303446";
    };
  };
}
