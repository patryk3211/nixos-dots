{ config, pkgs, ... }:
let
  swaylockBin = "${config.programs.swaylock.package}/bin/swaylock";
  hyprctlBin = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";

  screenOffTimeout = 60 * 5;
  lockTimeout = 60 * 10;
in {
  services.swayidle = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    events = [
      { event = "before-sleep"; command = "loginctl lock-session self"; }
      { event = "lock"; command = "${swaylockBin} -f"; }
    ];

    timeouts = [
      { timeout = screenOffTimeout; command = "${hyprctlBin} dispatch dpms off"; resumeCommand = "${hyprctlBin} dispatch dpms on"; }
      # { timeout = lockTimeout; command = "${swaylockBin} -f"; }
      # { timeout = lockTimeout + 3; command = "${hyprctlBin} dispatch dpms off"; resumeCommand = "${hyprctlBin} dispatch dpms on"; }
    ];
  };
}
