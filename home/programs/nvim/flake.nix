{
  description = "patryk3211 NeoVim Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # LSP
    nvim-lspconfig = { url = "github:neovim/nvim-lspconfig"; flake = false; };

    # Themes
    catppuccin = { url = "github:catppuccin/nvim"; flake = false; };

    # Utilities
    which-key = { url = "github:folke/which-key.nvim"; flake = false; };
  };

  outputs = { nixpkgs, flake-utils, ... } @ inputs: let
    availablePlugins = [
      "nvim-lspconfig"
      "catppuccin"
      "which-key"
    ];
    rawPlugins = nvimLib.plugins.inputsToRaw inputs availablePlugins;

    nvimConf = { modules ? [], ... } @ args:
      import ./default.nix
      (args // { modules = [{config.build.rawPlugins = rawPlugins;}] ++ modules; });
    nvimLib = (import ./lib/stdlib-extended.nix nixpkgs.lib).nvim;
    nvimBin = pkg: "${pkg}/bin/nvim";

    buildPkg = pkgs: modules: (nvimConf {
      inherit pkgs modules;
    });

    nixConfig = let
      overridable = nixpkgs.lib.mkOverride 1200;
    in {
      config = {
        nvim.theme.name = overridable "catppuccin-frappe";
      };
    };
  in {
    lib = {
      nvim = nvimLib;
      inherit nvimConf;
    };

    overlays.default = final: prev: {
      inherit nvimConf;

    };
  } // (flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
          })
        ];
      };
      nixPkg = buildPkg pkgs [nixConfig];
    in {
      apps = rec {
        nix = {
          type = "app";
          program = nvimBin nixPkg;
        };
        default = nix;
      } // pkgs.lib.optionalAttrs (!(builtins.elem system ["aarch64-darwin" "x86_64-darwin"])) {};
      packages = {
        default = nixPkg;
        nix = nixPkg;
      } // pkgs.lib.optionalAttrs (!(builtins.elem system ["aarch64-darwin" "x86_64-darwin"])) {};
      defaultPackage = nixPkg;
    }));
}
