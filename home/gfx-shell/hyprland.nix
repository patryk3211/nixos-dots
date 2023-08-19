{ config, lib, pkgs, ... }:
with lib;
{
  home.packages = with pkgs; [
    playerctl
    xdg-user-dirs
    (buildEnv { name = "hyprland-bins"; paths = [ ./hyprland-bins ]; })
    hyprpaper
    wl-clipboard
    grim
    slurp
    swappy
    jaq
  ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/.config/hypr/wallpaper.jpg
    wallpaper = eDP-1,~/.config/hypr/wallpaper.jpg
    wallpaper = HDMI-A-1,~/.config/hypr/wallpaper.jpg
  '';

  xdg.configFile."hypr/wallpaper.jpg".source = ./wallpaper.jpg;

  patmods.hyprland = {
    enable = true;
    modKey = "SUPER";
    
    startup = [
      "[workspace 9 silent] keepassxc"
      "thunderbird"
    ];

    binds = [
      { modifiers = [ "$mod" "SHIFT" ]; key = "E"; arg = "loginctl terminate-user 1000"; }
      # Hyprland actions
      { key = "Q"; dispatcher = "killactive"; }
      { key = "F"; dispatcher = "fullscreen"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "F"; dispatcher = "fullscreen"; arg = "1"; }
      { key = "T"; dispatcher = "togglefloating"; }

      # Launch programs
      { modifiers = [ "$mod" "SHIFT" ]; key = "T"; arg = "kitty"; }
      { key = "N"; arg = "pkill rofi || rofi-launcher"; }
      { key = "R"; arg = "pkill rofi || rofi-runner"; }
      { modifiers = []; key = "PRINT"; arg = "pkill rofi || rofi-screenshot"; }
      { key = "C"; arg = "pkill rofi || rofi-kalker"; }

      { modifiers = [ "$mod" "SHIFT" ]; key = "C"; arg = "kitty kalker"; }

      # Focus moving
      { key = "up"; dispatcher = "movefocus"; arg = "u"; }
      { key = "down"; dispatcher = "movefocus"; arg = "d"; }
      { key = "left"; dispatcher = "movefocus"; arg = "l"; }
      { key = "right"; dispatcher = "movefocus"; arg = "r"; }

      # Mouse actions
      { bindType = "m"; key = "mouse:272"; dispatcher = "movewindow"; }
      { bindType = "m"; key = "mouse:273"; dispatcher = "resizewindow"; }

      # Workspaces
      { key = "1"; dispatcher = "workspace"; arg = "1"; }
      { key = "2"; dispatcher = "workspace"; arg = "2"; }
      { key = "3"; dispatcher = "workspace"; arg = "3"; }
      { key = "4"; dispatcher = "workspace"; arg = "4"; }
      { key = "5"; dispatcher = "workspace"; arg = "5"; }
      { key = "6"; dispatcher = "workspace"; arg = "6"; }
      { key = "7"; dispatcher = "workspace"; arg = "7"; }
      { key = "8"; dispatcher = "workspace"; arg = "8"; }
      { key = "9"; dispatcher = "workspace"; arg = "9"; }

      { modifiers = [ "$mod" "SHIFT" ]; key = "1"; dispatcher = "movetoworkspace"; arg = "1"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "2"; dispatcher = "movetoworkspace"; arg = "2"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "3"; dispatcher = "movetoworkspace"; arg = "3"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "4"; dispatcher = "movetoworkspace"; arg = "4"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "5"; dispatcher = "movetoworkspace"; arg = "5"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "6"; dispatcher = "movetoworkspace"; arg = "6"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "7"; dispatcher = "movetoworkspace"; arg = "7"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "8"; dispatcher = "movetoworkspace"; arg = "8"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "9"; dispatcher = "movetoworkspace"; arg = "9"; }

      { key = "bracketleft"; dispatcher = "workspace"; arg = "m-1"; }
      { key = "bracketright"; dispatcher = "workspace"; arg = "m+1"; }

      { modifiers = [ "$mod" "SHIFT" ]; key = "bracketleft"; dispatcher = "focusmonitor"; arg = "l"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "bracketright"; dispatcher = "focusmonitor"; arg = "r"; }

      # Keyboard window resizing
      { modifiers = [ "$mod" "SHIFT" ]; key = "R"; dispatcher = "submap"; arg = "resize"; }
        { bindType = "e"; modifiers = []; key = "left"; dispatcher = "resizeactive"; arg = "-10 0"; submap = "resize"; }
        { bindType = "e"; modifiers = []; key = "right"; dispatcher = "resizeactive"; arg = "10 0"; submap = "resize"; }
        { bindType = "e"; modifiers = []; key = "up"; dispatcher = "resizeactive"; arg = "0 -10"; submap = "resize"; }
        { bindType = "e"; modifiers = []; key = "down"; dispatcher = "resizeactive"; arg = "0 10"; submap = "resize"; }

        { bindType = "e"; key = "left"; dispatcher = "resizeactive"; arg = "-50 0"; submap = "resize"; }
        { bindType = "e"; key = "right"; dispatcher = "resizeactive"; arg = "50 0"; submap = "resize"; }
        { bindType = "e"; key = "up"; dispatcher = "resizeactive"; arg = "0 -50"; submap = "resize"; }
        { bindType = "e"; key = "down"; dispatcher = "resizeactive"; arg = "0 50"; submap = "resize"; }

        { modifiers = []; key = "escape"; dispatcher = "submap"; arg = "reset"; submap = "resize"; }

      # Keyboard window movement
      { modifiers = [ "$mod" "SHIFT" ]; key = "M"; dispatcher = "submap"; arg = "move"; }
        { bindType = "e"; modifiers = []; key = "left"; dispatcher = "moveactive"; arg = "-10 0"; submap = "move"; }
        { bindType = "e"; modifiers = []; key = "right"; dispatcher = "moveactive"; arg = "10 0"; submap = "move"; }
        { bindType = "e"; modifiers = []; key = "up"; dispatcher = "moveactive"; arg = "0 -10"; submap = "move"; }
        { bindType = "e"; modifiers = []; key = "down"; dispatcher = "moveactive"; arg = "0 10"; submap = "move"; }

        { bindType = "e"; key = "left"; dispatcher = "moveactive"; arg = "-50 0"; submap = "move"; }
        { bindType = "e"; key = "right"; dispatcher = "moveactive"; arg = "50 0"; submap = "move"; }
        { bindType = "e"; key = "up"; dispatcher = "moveactive"; arg = "0 -50"; submap = "move"; }
        { bindType = "e"; key = "down"; dispatcher = "moveactive"; arg = "0 50"; submap = "move"; }

        { modifiers = []; key = "escape"; dispatcher = "submap"; arg = "reset"; submap = "move"; }

      { modifiers = [ "$mod" "ALT" ]; key = "M"; arg = "hypr-mousemode toggle"; }

      # Media keys
      { bindType = "l"; modifiers = []; key = "XF86AudioPlay"; arg = "playerctl play-pause"; }
      { bindType = "l"; modifiers = []; key = "XF86AudioPrev"; arg = "playerctl previous"; }
      { bindType = "l"; modifiers = []; key = "XF86AudioNext"; arg = "playerctl next"; }
      { bindType = "e"; modifiers = []; key = "XF86AudioRaiseVolume"; arg = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"; }
      { bindType = "e"; modifiers = []; key = "XF86AudioLowerVolume"; arg = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"; }
      { bindType = "l"; modifiers = []; key = "XF86AudioMute"; arg = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }

      { bindType = "l"; key = "M"; arg = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
    ];

    rules = [
      { rule = "idleinhibit none"; target = "(.*)"; }
      
      { rule = "workspace 4 silent"; target = "firefox"; }
      { rule = "workspace 6 silent"; target = "discord"; }
      { rule = "workspace 8 silent"; target = "thunderbird"; }
      # { rule = "workspace 9 silent"; target = "class:(org\.keepassxc\.KeePassXC),floating:0"; v2 = true; }

      { rule = "noinitialfocus"; target = "discord"; }
      { rule = "noinitialfocus"; target = "firefox"; }

      { rule = "idleinhibit focus"; target = "steam_app.*"; }
      { rule = "fullscreen"; target = "steam_app_1511460"; }

      { rule = "workspace 1 silent"; target = "([Mm]inecraft.*)"; }

      { rule = "stayfocused"; target = "(starship evo.exe)"; }
      { rule = "forceinput"; target = "(starship evo.exe)"; }
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    enableNvidiaPatches = true;

    recommendedEnvironment = true;

    extraConfig = ''
      input {
        kb_layout = pl

        follow_mouse = 2
      }

      general {
        gaps_in = 2
        gaps_out = 5
        border_size = 1

        col.active_border = rgb(${config.patmods.colors.hypr.border_active})
        col.inactive_border = rgb(${config.patmods.colors.hypr.border_inactive})
      }

      decoration {
        rounding = 8
      }

      misc {
        vrr = 1
        vfr = false
      }
    '';
  };

  systemd.user.services.hyprpaper = {
    Unit = {
      Description = "Hyprpaper Daemon";
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.hyprpaper}/bin/hyprpaper";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
