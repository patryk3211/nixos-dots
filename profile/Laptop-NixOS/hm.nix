{ options, config, pkgs, ... }:

{
  imports = [
    ./wm.nix
  ];

  home.packages = with pkgs; [
    sdrpp
  ];
}
