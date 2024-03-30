{ pkgs, ... }: let
  bcnc = import ./bcnc.nix { inherit pkgs; fetchurl = pkgs.fetchurl; fetchhg = pkgs.fetchhg; };
in {
  imports = [
    ./radio.nix
  ];

  home.packages = with pkgs; [
    blender
    # musescore
    (python311.withPackages(ps: [
      pkgs.python311Packages.cython
      (bcnc ps).bCNC
    ]))

    helvum
    easyeffects

    winetricks
    wine

    ffmpeg
    jetbrains.idea-community
    # blockbench-electron

    digikam

    transmission_4-gtk
    lunarvim
    
    kicad-small
  ];
}
