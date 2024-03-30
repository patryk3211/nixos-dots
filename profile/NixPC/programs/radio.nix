{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    (gnuradio.override {
      extraPackages = with gnuradioPackages; [
        osmosdr
      ];
    })
    sdrpp
  ];
}
