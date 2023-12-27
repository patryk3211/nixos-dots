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

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
    };
  };

  outputs = { nixpkgs,
              home-manager,
              lanzaboote,
              hyprland,
              eww,
              nvim,
              rust-overlay,
              nix-gaming,
              ... }: let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    userMod = import ./user.nix { };

    pkgs = (import nixpkgs {
      inherit system;
      overlays = [
        rust-overlay.overlays.default
        eww.overlays.default
        (final: prev: {
          neovim = nvim.packages.x86_64-linux.default;
          steam = prev.steam.override {
            extraProfile = "export STEAM_EXTRA_COMPAT_TOOLS_PATHS='${nix-gaming.packages.${prev.system}.proton-ge}'";
          };
          wine = nix-gaming.packages.${prev.system}.wine-ge;
        })
      ];
    });

    globalConf = [
      ./user.nix
      ./profile
      ./theme
    ];
  in {
    nixosConfigurations.${userMod.profile.hostname} = lib.nixosSystem {
      inherit system;

      modules = globalConf ++ [
        lanzaboote.nixosModules.lanzaboote
        nix-gaming.nixosModules.pipewireLowLatency
        ./profile/${userMod.profile.hostname}/os.nix
        ./nixos/configuration.nix
      ];
    };

    devShells.${system} = {
      eww = pkgs.mkShell {
        shellHook = ''
          # Initialize the eww development environment
          echo "Preparing development environment"

          WINDOWS=$(eww active-windows | grep -E '^[a-zA-Z]+' -o)

          systemctl --user stop eww.service
          mv -v ~/.config/eww ~/.config/eww.dir
          ln -vs $(realpath home/gfx-shell/eww-conf) ~/.config/eww
          systemctl --user start eww.service

          for wid in $WINDOWS; do
            eww open $wid
          done

          echo "Entered eww development mode"
          zsh
          echo "Leaving eww development mode"

          # Finalize the environment
          systemctl --user stop eww.service
          rm -v ~/.config/eww
          mv -v ~/.config/eww.dir ~/.config/eww
          systemctl --user start eww.service

          for wid in $WINDOWS; do
            eww open $wid
          done

          exit
        '';
      };
    };

    homeConfigurations."${userMod.profile.username}@${userMod.profile.hostname}" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = globalConf ++ [
        hyprland.homeManagerModules.default
        { imports = [
            ./profile/${userMod.profile.hostname}/hm.nix
            ./home/home.nix
          ];
        }
      ];
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://helix.cachix.org"
      "https://fufexan.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://hyprland.cachix.org"
      "https://cache.privatevoid.net"
    ];
    extra-trusted-public-keys = [
#      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="

      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "fufexan.cachix.org-1:LwCDjCJNJQf5XD2BV+yamQIMZfcKWR9ISIFy5curUsY="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cache.privatevoid.net:SErQ8bvNWANeAvtsOESUwVYr2VJynfuc9JRwlzTTkVg="
    ];
  };
}
