{ pkgs, lib, ... }: let
in {
  home.packages = with pkgs; [
    (gnuradio.override {
      extraPackages = with gnuradioPackages; [
        osmosdr
      ];
    })
    # sdrpp
    gpredict
  ];
}
