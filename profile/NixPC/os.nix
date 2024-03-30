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
}
