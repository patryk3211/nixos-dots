{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    prismlauncher
    (steam.override {
      extraProfile = "export STEAM_EXTRA_COMPAT_TOOLS_PATHS='${proton-ge-bin}'";
    })
  ];

  # programs.steam = {
  #   enable = true;
  #   extraCompatPackages = with pkgs; [
  #     proton-ge-bin
  #   ];
  # };
}
