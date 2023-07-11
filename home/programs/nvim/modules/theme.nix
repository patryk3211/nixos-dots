{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.patmods.neovim.theme;
in {
  options.nvim.theme = {
    enable = mkEnableOption "Enable NeoVim Theme";

    name = mkOption {
      type = types.str;
      description = ''
        Name of the colorscheme module of the theme.
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.neovim.plugins = [
      cfg.package
    ];

    patmods.neovim.luaConfig = ''
      vim.cmd [[colorscheme ${cfg.name}]]
    '';
  };
}
