{ options, pkgs, lib, ... }: let
  libraries = with pkgs; [
    # Basic libraries for graphical programs
    xorg.libXext
    xorg.libX11
    xorg.libXrender
    xorg.libXtst
    xorg.libXi
    libGL
    freetype
    fontconfig
  ];
in {
  programs.nix-ld = {
    enable = true;
    libraries = options.programs.nix-ld.libraries.default ++ libraries;
  };
  environment.sessionVariables = {
    LD_LIBRARY_PATH="${lib.makeLibraryPath libraries}";
  };
}
