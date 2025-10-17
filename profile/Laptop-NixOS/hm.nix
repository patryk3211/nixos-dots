{ options, config, pkgs, ... }:

{
  imports = [
    ./wm.nix
  ];

  home.packages = with pkgs; [
    # sdrpp
    lunarvim
    (gnuradio.override {
      extraPackages = with gnuradioPackages; [
        osmosdr
      ];
    })
    gpredict
  ];
}
