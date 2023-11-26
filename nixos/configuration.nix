# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [
    ./user.nix
    ./greetd.nix
    ./gnome.nix
    ./nixld.nix
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.trusted-users = [ config.profile.username ];
  };

  networking.hostName = config.profile.hostname;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [
      pkgs.brlaser
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };

  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        var YES = polkit.Result.YES;
        var permission = {
          // required for udisks1:
          "org.freedesktop.udisks.filesystem-mount": YES,
          "org.freedesktop.udisks.luks-unlock": YES,
          "org.freedesktop.udisks.drive-eject": YES,
          "org.freedesktop.udisks.drive-detach": YES,
          // required for udisks2:
          "org.freedesktop.udisks2.filesystem-mount": YES,
          "org.freedesktop.udisks2.encrypted-unlock": YES,
          "org.freedesktop.udisks2.eject-media": YES,
          "org.freedesktop.udisks2.power-off-drive": YES,
          // required for udisks2 if using udiskie from another seat (e.g. systemd):
          "org.freedesktop.udisks2.filesystem-mount-other-seat": YES,
          "org.freedesktop.udisks2.filesystem-unmount-others": YES,
          "org.freedesktop.udisks2.encrypted-unlock-other-seat": YES,
          "org.freedesktop.udisks2.encrypted-unlock-system": YES,
          "org.freedesktop.udisks2.eject-media-other-seat": YES,
          "org.freedesktop.udisks2.power-off-drive-other-seat": YES
        };
        if (subject.isInGroup("storage")) {
          return permission[action.id];
        }
      });
    '';
  };

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;

    lowLatency = {
      enable = true;
      quantum = 64;
      rate = 48000;
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    wget
    lxqt.lxqt-policykit
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services.openssh.enable = true;
  services.dbus.enable = true;

  programs.dconf.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      (xdg-desktop-portal-gtk.override {
        buildPortalsInGnome = false;
      })
    ];
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  security.pam.services.swaylock = {};

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "nvidia-settings"
    "nvidia-x11"
    "nvidia-persistenced"
  ];

  hardware.enableRedistributableFirmware = true;

  zramSwap = {
    enable = true;
    memoryMax = 4 * 1024 * 1024 * 1024;
  };

  services.udev.packages = [ pkgs.platformio ];
  services.fstrim.enable = true;
  services.udisks2.enable = true;

  programs.kdeconnect = {
    enable = true;
  };

  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    enableOnBoot = true;
  };

  system.activationScripts.binbash = ''
    mkdir -m 755 -p /bin
    ln -sfn ${pkgs.bash}/bin/bash /bin/bash
  '';

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
