{ pkgs, ... }: let
  bcnc = import ./bcnc.nix { inherit pkgs; fetchurl = pkgs.fetchurl; fetchhg = pkgs.fetchhg; };
in {

  home.packages = with pkgs; [
    blender
    musescore
    (python311.withPackages(ps: [
      pkgs.python311Packages.cython
      (bcnc ps).bCNC
    ]))

    helvum
    easyeffects

    # wineWowPackages.stable
    winetricks
    wine
    #wineWowPackages.waylandFull

    gwe

    ffmpeg
    jetbrains.idea-community
    blockbench-electron
  ];
}
