{ options, pkgs, lib, ... }: let
  libraries = with pkgs; [
    # Basic libraries for graphical programs
    xorg.libXext
    xorg.libX11
    xorg.libXrender
    xorg.libXtst
    xorg.libXi
    xorg.libXdamage
    xorg.libXrandr
    xorg.libXfixes
    xorg.libXcomposite
    xorg.libxcb
    xorg.xcbutil
    xorg.libxkbfile
    xorg.libxshmfence
    xorg.libXcursor
    xorg.xcbutilrenderutil
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilcursor
    egl-wayland
    wayland
    pulseaudio
    libGL
    freetype
    fontconfig
    libusb1
    # libxcrypt
    libxcrypt-legacy
    libdrm
    glib
    glibc
    libxkbcommon
    dbus
    krb5
    nss
    nspr
    atk
    cups
    gtk3
    pango
    cairo
    expat
    mesa
    libva
    pipewire
    alsa-lib
    libglvnd
  ];
in {
  programs.nix-ld = {
    enable = true;
    libraries = options.programs.nix-ld.libraries.default ++ libraries;
  };
  environment.sessionVariables = {
    PREP_LD_LIBRARY_PATH="${lib.makeLibraryPath libraries}:/run/opengl-driver/lib:/run/opengl-driver-32/lib";
  };
}
