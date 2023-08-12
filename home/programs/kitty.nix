{ config, pkgs, ... }:

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

  home.packages = [ (pkgs.writeShellScriptBin "nxterm" "exec -a $0 ${config.programs.kitty.package}/bin/kitty $@") ];
}
