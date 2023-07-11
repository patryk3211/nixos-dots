{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.patmods.neovim.lsp;
in {
  options.patmods.neovim.lsp = {
    enable = mkEnableOption "Enable NeoVim LspConfig plugin";

    package = mkOption {
      type = types.package;
      default = pkgs.vimPlugins.nvim-lspconfig;
    };

    bufferKeybinds = mkOption {
      type = types.listOf (types.submodule );
    };
  };

  config = mkIf cfg.enable {
    programs.neovim.plugins = [ cfg.package ];

    patmods.neovim.luaConfig = ''
      local lspConfig = require 'lspconfig'
      -- Setup language servers
      
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Autocompletion
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local keybinds
          local opts = { buffer = ev.buf }
        end,
      })
    '';
  };
}
