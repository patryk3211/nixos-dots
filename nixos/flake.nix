{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    lanzaboote.url = "github:nix-community/lanzaboote";
  };

  outputs = { self, nixpkgs, lanzaboote }: let
    hostnameMod = import ./hostname.nix { };
  in {
    nixosConfigurations.${hostnameMod.networking.hostName} = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        lanzaboote.nixosModules.lanzaboote
        ./configuration.nix
      ];
    };
  };
}
