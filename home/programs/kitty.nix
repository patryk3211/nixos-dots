{ config, ... }:

{
  programs.kitty = {
    enable = true;

    shellIntegration.enableZshIntegration = true;

    font = {
      size = 11;
      name = "FiraCode";
    };

    settings = {
    } // config.patmods.colors.terminal;
  };
}
