{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.patmods.neovim.whichkey;
in {
  options.patmods.neovim.whichkey = {
    enable = mkEnableOption "Enable whichkey plugin";

    package = mkOption {
      type = types.package;
      default = pkgs.vimPlugins.which-key-nvim;
    };

    timeout = mkOption {
      type = types.int;
      default = 500;
    };
  };

  config = mkIf cfg.enable {
    programs.neovim.plugins = [ cfg.package ];

    patmods.neovim.luaConfig = ''
      vim.o.timeout = true;
      vim.o.timeoutlen = ${toString cfg.timeout};
      require('which-key').setup {
      };
    '';
  };
}
