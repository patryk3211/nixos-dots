{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.patmods.eww;

  dependencies = with pkgs; [
    cfg.package
    config.wayland.windowManager.hyprland.package

    bash
    jaq
    socat
    ripgrep
    librsvg
    pipewire
    wireplumber
    kalker
    playerctl
    coreutils-full
  ];
in {
  options.patmods.eww = {
    enable = mkEnableOption "eww";

    package = mkOption {
      type = types.package;
      default = pkgs.eww;
      defaultText = literalExpression "pkgs.eww";
      example = literalExpression "pkgs.eww";
      description = ''
        The eww package to install
      '';
    };

    autoReload = mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = ''
        Should eww be reloaded when configuration changes
      '';
    };

    configDirectory = mkOption {
      type = types.path;
      default = ./eww;
      example = ./eww;
      description = ''
        Directory to link to .config/eww
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = dependencies;

    xdg.configFile."eww" = {
      source = cfg.configDirectory;
      recursive = true;
      #onChange = "systemctl --user restart eww.service"
    };

    xdg.configFile."eww/generated/yuck/help.yuck".text = with lib; let
      alternativeKeys = {
        "$mod" = " ";
        "mouse:272" = "Left Mouse";
        "mouse:273" = "Right Mouse";
        "XF86AudioPlay" = "Media Play";
        "XF86AudioPrev" = "Media Previous";
        "XF86AudioNext" = "Media Next";
        "XF86AudioRaiseVolume" = "Media Volume Up";
        "XF86AudioLowerVolume" = "Media Volume Down";
        "XF86AudioMute" = "Media Mute";
        "left" = "󰁍";
        "right" = "󰁔";
        "up" = "󰁝";
        "down" = "󰁅";
        "escape" = "Escape";
        "bracketleft" = "[";
        "bracketright" = "]";
      };
    in ''
      ; Generated in 'home/gfx-shell/modules/eww.nix'
      (defwidget generatedKeybinds []
        (box :orientation "v"
      ${concatStringsSep "\n" (attrsets.mapAttrsToList (n: v:
          concatStringsSep "\n" (map (bind:
            ''(box :class "entry"
                   :space-evenly false
                (label :xalign "0" :class "modkeys" :text "${concatStringsSep " " (map (v: alternativeKeys.${v} or v) bind.modifiers)}")
                (label :xalign "0" :class "mainkey" :text "${alternativeKeys.${bind.key} or bind.key}")
                (label :xalign "0" :class "submap" :text "${if isNull bind.submap then "" else bind.submap}")
                (label :hexpand true :xalign "0" :class "description" :text "${bind.help}")
              )''
          ) v)
      ) (lists.groupBy (v: if v.submap == null then "reset" else v.submap) config.patmods.hyprland.binds))}
        )
      )
    '';
    
    systemd.user.services.eww = {
      Unit = {
        Description = "eww Daemon";
        PartOf = [ "graphical-session.target" ];
        After = [ "basic.target" ];
      };
      Service = {
        Environment = "PATH=/run/wrappers/bin:${makeBinPath dependencies}";
        ExecStart = "${cfg.package}/bin/eww daemon --no-daemonize";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
