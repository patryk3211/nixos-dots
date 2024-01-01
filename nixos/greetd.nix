{ config, pkgs, lib, ... }:
with lib;
let
  /*hyprConf = pkgs.writeText "hyprland.conf" ''
    ${concatStringsSep "\n" (attrsets.mapAttrsToList (n: v:
      "monitor = ${n}, ${v.resolution}@${v.framerate}, ${v.position}, ${v.scale}"
    ) config.profile.wm.monitors)}

    ${concatStringsSep "\n" (
      attrsets.mapAttrsToList (n: v:
        "env = ${n},${v}"
      ) config.profile.wm.env
    )}

    exec-once = dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK
    exec-once = ${pkgs.greetd.}/bin/gtkgreet; ${pkgs.hyprland}/bin/hyprctl dispatch exit
  '';
  greetStartup = pkgs.writeText "greet-startup" ''
    ${pkgs.hyprland}/bin/Hyprland -c ${hyprConf}
  '';*/
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

  /*programs.regreet = {
    enable = true;
    settings = {
     background = {
       path = "/usr/share/backgrounds/login.png";
       fit = "Contain";
     };
     GTK = {
       application_prefer_dark_theme = true;
       cursor_theme_name = config.theme.cursor.name;
       icon_theme_name = config.theme.icon.name;
       theme_name = config.theme.gtk.name;
       font = "Iosevka 16";
     };
    };
  };*/

  systemd.services.disableDmesgToConsole = {
    wantedBy = [ "multi-user.target" ];
    description = "Disable DMesg logging to console";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.util-linux}/bin/dmesg -D";
    };
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd 'zsh -c Hyprland'";
        #command = "${pkgs.bash}/bin/bash ${greetStartup}";
        user = "greeter";
      };
    };
    restart = false;
  };

  environment.etc."greetd/sessions/Hyprland.desktop".text = ''
    [Desktop Entry]
    Name=Hyprland
    Exec=${pkgs.bash} -c 'Hyprland'
    Type=Application
  '';
}
