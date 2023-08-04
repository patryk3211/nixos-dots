{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./wm.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    tmp = {
      useTmpfs = true;
    };
  };
}
