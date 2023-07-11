{ config, pkgs, ... }:
let
  swaylockBin = "${config.programs.swaylock.package}/bin/swaylock";
  hyprctlBin = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";

  idleTimeout = 60 * 5;
in {
  home.packages = with pkgs; [
  ];

  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    events = [
      { event = "before-sleep"; command = "loginctl lock-session self"; }
      { event = "lock"; command = "${swaylockBin} -f"; }
    ];

    timeouts = [
      { timeout = idleTimeout; command = "${swaylockBin} -f"; }
      { timeout = idleTimeout + 1; command = "${hyprctlBin} dispatch dpms off"; resumeCommand = "${hyprctlBin} dispatch dpms on"; }
    ];
  };
}
