{ config, pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./wm.nix
  ];

  environment.systemPackages = with pkgs; [
    rtl-sdr
    hplip
    xclip
  ];

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
        glibc
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

  # Uncomment to switch to XFCE desktop
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
    xkb.layout = "pl";
    exportConfiguration = true;
  };

  services.displayManager.defaultSession = "xfce";
  services.greetd.enable = lib.mkForce false;
  users.groups.greeter = {};

  systemd.services.NetworkManager-wait-online.enable = false;
  # systemd.network.wait-online.enable = false;
}
