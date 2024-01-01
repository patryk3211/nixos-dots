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
      { modifiers = [ "$mod" "SHIFT" ]; key = "E"; arg = "loginctl terminate-user 1000"; help = "Logout"; }
      # Hyprland actions
      { key = "Q"; dispatcher = "killactive"; help = "Close current window"; }
      { key = "F"; dispatcher = "fullscreen"; arg = "1"; help = "Toggle current window semi-fullscreen"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "F"; dispatcher = "fullscreen"; help = "Toggle current window fullscreen"; }
      { key = "T"; dispatcher = "togglefloating"; help = "Toggle current window floating"; }

      # Launch programs
      { modifiers = [ "$mod" "SHIFT" ]; key = "T"; arg = "kitty"; help = "Spawn new terminal"; }
      { key = "N"; arg = "pkill rofi || rofi-launcher"; help = "Open application launcher"; }
      { key = "R"; arg = "pkill rofi || rofi-runner"; help = "Open runner"; }
      { modifiers = []; key = "PRINT"; arg = "pkill rofi || rofi-screenshot"; help = "Take a screenshot"; }
      { key = "C"; arg = "pkill rofi || rofi-kalker"; help = "Open quick calculator"; }

      { modifiers = [ "$mod" "SHIFT" ]; key = "C"; arg = "kitty kalker"; help = "Open kalker"; }
      
      { modifiers = [ "$mod" "SHIFT" ]; key = "H"; arg = "eww open keybinds"; help = "Open this keybind viewer"; }

      # Focus moving
      { key = "up"; dispatcher = "movefocus"; arg = "u"; help = "Move focus up"; }
      { key = "down"; dispatcher = "movefocus"; arg = "d"; help = "Move focus down"; }
      { key = "left"; dispatcher = "movefocus"; arg = "l"; help = "Move focus left"; }
      { key = "right"; dispatcher = "movefocus"; arg = "r";  help = "Move focus right"; }

      # Mouse actions
      { bindType = "m"; key = "mouse:272"; dispatcher = "movewindow"; help = "Move window"; }
      { bindType = "m"; key = "mouse:273"; dispatcher = "resizewindow"; help = "Resize window"; }

      # Workspaces
      { key = "1"; dispatcher = "workspace"; arg = "1"; help = "Switch to workspace 1"; }
      { key = "2"; dispatcher = "workspace"; arg = "2"; help = "Switch to workspace 2"; }
      { key = "3"; dispatcher = "workspace"; arg = "3"; help = "Switch to workspace 3"; }
      { key = "4"; dispatcher = "workspace"; arg = "4"; help = "Switch to workspace 4"; }
      { key = "5"; dispatcher = "workspace"; arg = "5"; help = "Switch to workspace 5"; }
      { key = "6"; dispatcher = "workspace"; arg = "6"; help = "Switch to workspace 6"; }
      { key = "7"; dispatcher = "workspace"; arg = "7"; help = "Switch to workspace 7"; }
      { key = "8"; dispatcher = "workspace"; arg = "8"; help = "Switch to workspace 8"; }
      { key = "9"; dispatcher = "workspace"; arg = "9"; help = "Switch to workspace 9"; }

      { modifiers = [ "$mod" "SHIFT" ]; key = "1"; dispatcher = "movetoworkspace"; arg = "1"; help = "Move current window to workspace 1"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "2"; dispatcher = "movetoworkspace"; arg = "2"; help = "Move current window to workspace 2"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "3"; dispatcher = "movetoworkspace"; arg = "3"; help = "Move current window to workspace 3"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "4"; dispatcher = "movetoworkspace"; arg = "4"; help = "Move current window to workspace 4"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "5"; dispatcher = "movetoworkspace"; arg = "5"; help = "Move current window to workspace 5"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "6"; dispatcher = "movetoworkspace"; arg = "6"; help = "Move current window to workspace 6"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "7"; dispatcher = "movetoworkspace"; arg = "7"; help = "Move current window to workspace 7"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "8"; dispatcher = "movetoworkspace"; arg = "8"; help = "Move current window to workspace 8"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "9"; dispatcher = "movetoworkspace"; arg = "9"; help = "Move current window to workspace 9"; }

      { key = "bracketleft"; dispatcher = "workspace"; arg = "m-1"; help = "Switch to previous workspace"; }
      { key = "bracketright"; dispatcher = "workspace"; arg = "m+1"; help = "Switch to next workspace"; }

      { modifiers = [ "$mod" "SHIFT" ]; key = "bracketleft"; dispatcher = "focusmonitor"; arg = "l"; help = "Move focus to previous monitor"; }
      { modifiers = [ "$mod" "SHIFT" ]; key = "bracketright"; dispatcher = "focusmonitor"; arg = "r"; help = "Move focus to next monitor"; }

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
      { modifiers = [ "$mod" "ALT" ]; key = "G"; arg = "hypr-gamemode toggle"; }

      # Media keys
      { bindType = "l"; modifiers = []; key = "XF86AudioPlay"; arg = "playerctl play-pause"; help = "Play/pause current media player"; }
      { bindType = "l"; modifiers = []; key = "XF86AudioPrev"; arg = "playerctl previous"; help = "Play previous media"; }
      { bindType = "l"; modifiers = []; key = "XF86AudioNext"; arg = "playerctl next"; help = "Play next media"; }
      { bindType = "e"; modifiers = []; key = "XF86AudioRaiseVolume"; arg = "wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"; help = "Raise volume by 5%"; }
      { bindType = "e"; modifiers = []; key = "XF86AudioLowerVolume"; arg = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"; help = "Lower volume by 5%"; }
      { bindType = "l"; modifiers = []; key = "XF86AudioMute"; arg = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; help = "Toggle audio mute"; }

      { bindType = "l"; key = "M"; arg = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; help = "Toggle microphone mute"; }
    ];

    rules = [
      { rule = "idleinhibit none"; target = "(.*)"; }
      
      { rule = "workspace 4 silent"; target = "firefox"; }
      { rule = "workspace 6 silent"; target = "discord"; }
      { rule = "workspace 6 silent"; target = "WebCord"; }
      { rule = "workspace 8 silent"; target = "thunderbird"; }
      { rule = "workspace 9 silent"; target = "class:(org\.keepassxc\.KeePassXC),floating:0"; v2 = true; }

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
    # enableNvidiaPatches = true;

    # recommendedEnvironment = true;

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
        vrr = 2
        vfr = true
        mouse_move_enables_dpms = true
        key_press_enables_dpms = true
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
