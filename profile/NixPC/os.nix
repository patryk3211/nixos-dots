{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./wm.nix
    # ./nvidiax.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    tmp = {
      useTmpfs = true;
      tmpfsSize = "75%";
    };
  };
}
