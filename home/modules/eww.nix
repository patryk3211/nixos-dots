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
  ];
in {
  options.patmods.eww = {
    enable = mkEnableOption "eww";

    package = mkOption {
      type = types.package;
      default = pkgs.eww-wayland;
      defaultText = literalExpression "pkgs.eww-wayland";
      example = literalExpression "pkgs.eww-wayland";
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
