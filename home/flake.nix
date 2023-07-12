{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    eww = {
      url = "github:elkowar/eww";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim = {
      url = "github:patryk3211/neovim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, hyprland, nvim, ... }: let
    userMod = import ./user.nix { };
  in {
    homeConfigurations."${userMod.home.username}" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      extraSpecialArgs = { inherit nvim; };
      modules = [
        hyprland.homeManagerModules.default
        { imports = [ ./home.nix ]; }
      ];
    };
  };
}
