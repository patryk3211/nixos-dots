{ config, lib, ... }:
with lib;
let
  cfg = config.patmods.hyprland;
  
  hyprBind = {...}: {
    options = {
      bindType = mkOption {
        type = types.str;
        default = "";
      };
      
      modifiers = mkOption {
        type = types.listOf types.str;
        default = [ "$mod" ];
      };

      key = mkOption {
        type = types.str;
      };
      
      dispatcher = mkOption {
        type = types.str;
        default = "exec";
      };

      arg = mkOption {
        type = types.nullOr types.str;
        default = null;
      };

      submap = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
    };
  };
  
  hyprRule = {...}: {
    options = {
      target = mkOption {
        type = types.str;
      };
      rule = mkOption {
        type = types.str;
      };
      v2 = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };
in {
  options.patmods.hyprland = {
    enable = mkEnableOption "Enable patmod for Hyprland";

    modKey = mkOption {
      type = types.str;
      default = "SUPER";
    };

    startup = mkOption {
      type = types.listOf types.str;
      default = [];
    };

    binds = mkOption {
      type = types.listOf (types.submodule hyprBind);
      default = [];
    };

    rules = mkOption {
      type = types.listOf (types.submodule hyprRule);
      default = [];
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.extraConfig = ''
      $mod = ${cfg.modKey}

      # Monitors
      ${concatStringsSep "\n" (attrsets.mapAttrsToList (n: v:
        "monitor = ${n}, ${v.resolution}@${v.framerate}, ${v.position}, ${v.scale}"
      ) config.profile.wm.monitors)}

      # Configure environment
      ${concatStringsSep "\n" (
        attrsets.mapAttrsToList (n: v:
          "env = ${n},${v}"
        ) config.profile.wm.env
      )}

      env = XCURSOR_SIZE,${toString config.home.pointerCursor.size}
      env = XCURSOR_THEME,${config.home.pointerCursor.name}

      # Startup programs
      exec-once = dbus-update-activation-environment --systemd DBUS_SESSION_BUS_ADDRESS DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE
      exec-once = eww open mainbar
      exec-once = hyprctl setcursor $XCURSOR_THEME $XCURSOR_SIZE

      ${concatStringsSep "\n" (map (v: "exec-once = ${v}") cfg.startup)}

      # Binds
      ${concatStringsSep "\n" (attrsets.mapAttrsToList (n: v:
        ''
          submap = ${n}
          ${concatStringsSep "\n" (map (bind: let
            modStr = concatStringsSep " " bind.modifiers;
            argStr = if bind.arg == null then "" else ", ${bind.arg}";
          in "bind${bind.bindType} = ${modStr}, ${bind.key}, ${bind.dispatcher} ${argStr}") v)}
        ''
      ) (lists.groupBy (v: if v.submap == null then "reset" else v.submap) cfg.binds))}

      # Rules
      ${concatStringsSep "\n" (map (v: let
        ruleType = if v.v2 then "windowrulev2" else "windowrule";
      in "${ruleType} = ${v.rule}, ${v.target}"
      ) cfg.rules)}
    '';
  };
}
