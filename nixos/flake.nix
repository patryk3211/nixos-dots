{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    lanzaboote.url = "github:nix-community/lanzaboote";
  };

  outputs = { self, nixpkgs, lanzaboote }: {
    nixosConfigurations."Laptop-NixOS" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        lanzaboote.nixosModules.lanzaboote
        ./configuration.nix
      ];
    };
  };
}
