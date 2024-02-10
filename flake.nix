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

    configsToGenerate = (import ./configurations.nix);

    globalConf = [
      ./profile
      ./theme
    ];
  in {
    nixosConfigurations = with builtins; listToAttrs (map (host: {
      name = host.hostname;
      value = lib.nixosSystem {
        inherit system;

        modules = globalConf ++ host.osConfigs ++ [
          lanzaboote.nixosModules.lanzaboote
          nix-gaming.nixosModules.pipewireLowLatency
          ({ ... }: {
            networking.hostName = host.hostname;
            users.users = listToAttrs (map (user: {
              name = user.username;
              value = {
                isNormalUser = true;
                extraGroups = user.groups or [];
              };
            }) host.users);
            nix.settings.trusted-users = (map (user: user.username) (filter (user: user.trustedUser) host.users));
          })
          ./nixos/configuration.nix
        ];
      };
    }) configsToGenerate);

    homeConfigurations = with builtins; listToAttrs (concatMap (host: (map (user: {
      name = "${user.username}@${host.hostname}";
      value = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = globalConf ++ user.homeManagerConfigs ++ [
          hyprland.homeManagerModules.default
          ({ ... }: {
            profile = {
              username = user.username;
              homeDirectory = user.homeDirectory;
              hostname = host.hostname;
            };
          })
          ./home/home.nix
        ];
      };
    }) host.users)) configsToGenerate);

    devShells.${system} = {
      eww = pkgs.mkShell {
        shellHook = ''
          # Initialize the eww development environment
          echo "Preparing development environment"

          if [[ -e '~/.config/eww.dir' ]]; then
            echo "Eww development environment already active"
            exit
          fi

          WINDOWS=$(eww active-windows | grep -E '^[a-zA-Z]+' -o)

          systemctl --user stop eww.service
          mv -v ~/.config/eww ~/.config/eww.dir
          mkdir ~/.config/eww
          for f in $(ls home/gfx-shell/eww-conf); do
            ln -vs $(realpath home/gfx-shell/eww-conf/$f) ~/.config/eww
          done
          ln -vs ~/.config/eww.dir/generated ~/.config/eww
          # ln -vs $(realpath home/gfx-shell/eww-conf) ~/.config/eww
          systemctl --user start eww.service

          for wid in $WINDOWS; do
            eww open $wid
          done

          echo "Entered eww development mode"
          zsh
          echo "Leaving eww development mode"

          # Finalize the environment
          systemctl --user stop eww.service
          rm -vr ~/.config/eww
          mv -v ~/.config/eww.dir ~/.config/eww
          systemctl --user start eww.service

          for wid in $WINDOWS; do
            eww open $wid
          done

          exit
        '';
      };
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://helix.cachix.org"
      "https://fufexan.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://hyprland.cachix.org"
      # "https://cache.privatevoid.net"
    ];
    extra-trusted-public-keys = [
#      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="

      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "fufexan.cachix.org-1:LwCDjCJNJQf5XD2BV+yamQIMZfcKWR9ISIFy5curUsY="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      # "cache.privatevoid.net:SErQ8bvNWANeAvtsOESUwVYr2VJynfuc9JRwlzTTkVg="
    ];
  };
}
