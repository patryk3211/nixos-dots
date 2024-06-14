{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./wm.nix
  ];

  environment.systemPackages = [ pkgs.rtl-sdr ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    tmp = {
      useTmpfs = true;
      tmpfsSize = "75%";
    };
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    package = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils
        mangohud
        (writeShellScriptBin "launch-gamescope" ''
          (sleep 1; pgrep gamescope | xargs renice -n -11 -p)&
          exec gamescope "$@"
        '')
      ];
    };
  };
}
