{ lib }: {
  plugins = import ./plugins.nix { inherit lib; };
}
