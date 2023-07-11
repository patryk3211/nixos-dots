{ pkgs, lib, check ? true }:
let
  modules = [
    ./theme.nix
  ];

  pkgsModules = { config, ... }: {
    config = {
      _module.args.baseModules = modules;
      _module.args.pkgsPath = lib.mkDefault pkgs.path;
      _module.args.pkgs = lib.mkDefault pkgs;
      _module.check = check;
    };
  };
in
  modules ++ [pkgsModules];

/*{ config, lib, ... }:
with lib;
let
  cfg = config.patmods.neovim;
  keybindModule = {
    options = {
      mode = mkOption {
        type = types.str;
      };
      keys = mkOption {
        type = types.str;
      };
      bind = mkOption {
        type = types.str;
      };
      description = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
    };
  };

  bindOptions = (desc: if desc == null then "{}" else "{ desc = '${desc}' }");

  keybinds = concatStringsSep "" (
    map 
      (v: "vim.keymap.set('${v.mode}', '${v.keys}', ${v.bind}, ${bindOptions v.description})") 
      cfg.globalKeybinds);
in {
  options.patmods.neovim = {
    enable = mkEnableOption "Enable NeoVim";

    luaConfig = mkOption {
      type = types.lines;
      default = "";
      example = "";
      description = ''
        NeoVim lua init script.
      '';
    };

    globalKeybinds = mkOption {
      type = types.listOf (types.submodule keybindModule);
      default = [];
    };
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;

      extraConfig = ''
        lua <<
        ${cfg.luaConfig}
        ${keybinds}

      '';
    };
  };

  imports = [
    ./theme.nix
    ./whichkey.nix
    ./lsp.nix
  ];
}*/
