{ config, pkgs, ... }:

{
#  environment.systemPackages = with pkgs; [
#    wayland
#    eww-wayland
#  ];

#  programs.hyprland = {
#    enable = true;
#    xwayland.enable = true;
#  };

  services.dbus.enable = true;
#  xdg.portal = {
#    enable = true;
#    wlr.enable = true;
#  };
}

