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
    libusb1
  ];
in {
  programs.nix-ld = {
    enable = true;
    libraries = options.programs.nix-ld.libraries.default ++ libraries;
  };
  environment.sessionVariables = {
    LD_LIBRARY_PATH="${lib.makeLibraryPath libraries}:/run/opengl-driver/lib:/run/opengl-driver-32/lib";
  };
}
