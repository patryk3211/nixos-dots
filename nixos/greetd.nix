{ config, pkgs, lib, ... }:
with lib;
let
  swayStartup = pkgs.writeText "sway-startup" ''
    ${concatStringsSep "\n" (attrsets.mapAttrsToList (n: v: "export ${n}=${v}") config.profile.wm.env)}
    ${pkgs.sway}/bin/sway --config ${swayConf} --unsupported-gpu
  '';
  swayConf = pkgs.writeText "sway.conf" ''
    ${concatStringsSep "\n" (attrsets.mapAttrsToList (n: v: 
      ''output ${n} {
        mode ${v.resolution}@${v.framerate}Hz
        scale ${v.scale}
      }''
    ) config.profile.wm.monitors)}

    exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK
    exec "${config.programs.regreet.package}/bin/regreet; ${pkgs.sway}/bin/swaymsg exit"
  '';
in {
  environment.systemPackages = [
    config.theme.cursor.package
    config.theme.gtk.package
    config.theme.icon.package
    pkgs.iosevka
  ];

  users.users."greeter" = {
    isSystemUser = true;
    group = "greeter";
  };

  programs.regreet = {
    enable = true;
    settings = {
      env = config.profile.wm.env // {
        XDG_CURRENT_DESKTOP = "sway";
        XDG_SESSION_DESKTOP = "sway";
      };
      GTK = {
        application_prefer_dark_theme = true;
        cursor_theme_name = config.theme.cursor.name;
        icon_theme_name = config.theme.icon.name;
        theme_name = config.theme.gtk.name;
        font = "Iosevka 16";
      };
    };
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.bash}/bin/bash ${swayStartup}";
        user = "greeter";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    Hyprland
  '';
}
