{ config, pkgs, ... }:

{
  services.gvfs.enable = true;
  services.colord.enable = true;

  services.gnome = {
    glib-networking.enable = true;
    tracker.enable = true;
    tracker-miners.enable = true;
    sushi.enable = true;
    at-spi2-core.enable = true;
    gnome-settings-daemon.enable = true;
  };
}
