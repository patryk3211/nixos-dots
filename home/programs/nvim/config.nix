{ config, pkgs, ... }:

{
  patmods.neovim = {
    enable = true;

    theme = {
      enable = true;
      package = pkgs.vimPlugins.catppuccin-nvim;
      name = "catppuccin-frappe";
    };

    globalKeybinds = [
      {
        mode = "n";
        keys = "<space>f";
        bind = "vim.diagnostic.open_float";
        description = "Open diagnostic messages in a float";
      }
    ];

    whichkey.enable = true;
    lsp.enable = true;
  };
}
