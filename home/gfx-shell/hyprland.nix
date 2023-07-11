{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    playerctl
    xdg-user-dirs
    (buildEnv { name = "hyprland-bins"; paths = [ ./hyprland-bins ]; })
    hyprpaper
    wl-clipboard
    grim
    slurp
    jaq
  ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/.config/hypr/wallpaper.jpg
    wallpaper = eDP-1,~/.config/hypr/wallpaper.jpg
    wallpaper = HDMI-A-1,~/.config/hypr/wallpaper.jpg
  '';

  xdg.configFile."hypr/wallpaper.jpg".source = ./wallpaper.jpg;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    recommendedEnvironment = true;

    extraConfig = ''
      $mod = SUPER

      # Monitors
      monitor = eDP-1, 1920x1080@60, 0x0, 1
      monitor = HDMI-A-1, 1920x1080@60, 0x0, 1

      # Configure environment
      env = _JAVA_AWT_WM_NONREPARENTING,1
      env = GDK_BACKEND,wayland,x11
      env = SDL_VIDEODRIVER,wayland
      env = CLUTTER_BACKEND,wayland

      env = XDG_CURRENT_DESKTOP,Hyprland
      env = XDG_SESSION_TYPE,wayland
      env = XDG_SESSION_DESKTOP,Hyprland

      env = QT_QPA_PLATFORM,wayland;xcb
      env = QT_AUTO_SCREEN_SCALE_FACTOR,1
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env = QT_QPA_PLATFORMTHEME,qt5ct

      env = XCURSOR_SIZE,${toString config.home.pointerCursor.size}
      env = XCURSOR_THEME,${config.home.pointerCursor.name}

      exec-once = eww open mainbar
      exec-once = hyprctl setcursor $XCURSOR_THEME $XCURSOR_SIZE

      exec-once = keepassxc

      input {
        kb_layout = pl
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

      # Hyprland actions
      bind = $mod SHIFT, E, exec, pkill Hyprland
      bind = $mod, Q, killactive
      bind = $mod, F, fullscreen
      bind = $mod, T, togglefloating

      # Launch programs
      bind = $mod SHIFT, T, exec, kitty
      bind = $mod, N, exec, pkill rofi || rofi-launcher
      bind = $mod, R, exec, pkill rofi || rofi-runner
      bind = , PRINT, exec, pkill rofi || rofi-screenshot
      bind = $mod, C, exec, kitty kalker

      # Focus moving
      bind = $mod, up, movefocus, u
      bind = $mod, down, movefocus, d
      bind = $mod, left, movefocus, l
      bind = $mod, right, movefocus, r

      # Mouse actions
      bindm = $mod, mouse:272, movewindow
      bindm = $mod, mouse:273, resizewindow

      # Workspaces
      bind = $mod, 1, workspace, 1
      bind = $mod, 2, workspace, 2
      bind = $mod, 3, workspace, 3
      bind = $mod, 4, workspace, 4
      bind = $mod, 5, workspace, 5
      bind = $mod, 6, workspace, 6
      bind = $mod, 7, workspace, 7
      bind = $mod, 8, workspace, 8
      bind = $mod, 9, workspace, 9

      bind = $mod SHIFT, 1, movetoworkspace, 1
      bind = $mod SHIFT, 2, movetoworkspace, 2
      bind = $mod SHIFT, 3, movetoworkspace, 3
      bind = $mod SHIFT, 4, movetoworkspace, 4
      bind = $mod SHIFT, 5, movetoworkspace, 5
      bind = $mod SHIFT, 6, movetoworkspace, 6
      bind = $mod SHIFT, 7, movetoworkspace, 7
      bind = $mod SHIFT, 8, movetoworkspace, 8
      bind = $mod SHIFT, 9, movetoworkspace, 9

      bind = $mod, bracketleft, workspace, m-1
      bind = $mod, bracketright, workspace, m+1
      bind = $mod SHIFT, bracketleft, focusmonitor, l
      bind = $mod SHIFT, bracketright, focusmonitor, r

      bind = $mod SHIFT, R, submap, resize
      bind = $mod SHIFT, M, submap, move
      submap = resize
        binde = , left, resizeactive, -10 0
        binde = , right, resizeactive, 10 0
        binde = , up, resizeactive, 0 -10
        binde = , down, resizeactive, 0 10
        bind = , escape, submap, reset
      submap = move
        binde = , left, moveactive, -10 0
        binde = , right, moveactive, 10 0
        binde = , up, moveactive, 0 -10
        binde = , down, moveactive, 0 10
        bind = , escape, submap, reset
      submap = reset

      # Media keys
      bindl = , XF86AudioPlay, exec, playerctl play-pause
      bindl = , XF86AudioPrev, exec, playerctl previous
      bindl = , XF86AudioNext, exec, playerctl next

      binde = , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
      binde = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      
      bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

      # Window rules
      windowrule = idleinhibit none, (.*)

      windowrule = workspace 9, org\.keepassxc\.KeePassXC
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
