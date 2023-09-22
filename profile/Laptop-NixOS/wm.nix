{ options, config, ... }:

{
  profile = {
    wm = {
      monitors = {
        "eDP-1" = {
          resolution = "1920x1080";
          framerate = "60";
          position = "0x0";
          scale = "1";
        };
      };
    };
  };
}

