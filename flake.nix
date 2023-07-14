{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote.url = "github:nix-community/lanzaboote";

    hyprland.url = "github:hyprwm/Hyprland";

    eww = {
      url = "github:elkowar/eww";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim = {
      url = "github:patryk3211/neovim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs,
              home-manager,
              lanzaboote,
              hyprland,
              eww,
              nvim,
              rust-overlay,
              ... }: let
    system = "x86_64-linux";
    userMod = import ./user.nix { };
  in {
    nixosConfigurations.${userMod.profile.hostname} = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        lanzaboote.nixosModules.lanzaboote
        ./user.nix
        ./profile
        ./nixos/configuration.nix
        ./profile/${userMod.profile.hostname}/hardware-configuration.nix
      ];
    };

    homeConfigurations."${userMod.profile.username}@${userMod.profile.hostname}" = home-manager.lib.homeManagerConfiguration {
      pkgs = (import nixpkgs { inherit system; overlays = [
        rust-overlay.overlays.default
        eww.overlays.default
        (final: prev: { neovim = nvim.packages.x86_64-linux.default; })
      ]; });

      modules = [
        hyprland.homeManagerModules.default
        { imports = [
            ./user.nix
            ./profile
            ./profile/${userMod.profile.hostname}
            ./home/home.nix
          ];
        }
      ];
    };
  };
}
