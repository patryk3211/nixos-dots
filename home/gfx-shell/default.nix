{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
  ];

  imports = [
    ./hyprland.nix
    ./eww.nix
    ./dunst.nix
    ./rofi.nix
    ./swaylock.nix
    ./swayidle.nix
  ];

  catppuccin = {
    enable = true;
    flavor = "frappe";
    accent = "blue";

    cursors = {
      enable = true;
      flavor = "frappe";
      accent = "blue";
    };
  };
}
