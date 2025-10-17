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
    ./firewall.nix
    ./polkit.nix
  ];

  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

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
    startWhenNeeded = true;
    drivers = [
      pkgs.brlaser
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
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

  programs.gamemode = {
    enable = true;
    settings = {
      general.renice = 10;
      
      # gpu = {
      #   apply_gpu_optimisations = "accept-responsibility";
      #   gpu_device = 0;
      # };

      # custom = {
      #   start = ''
      #     nvidia-settings -a '[gpu:0]/GPUPowerMizerMode=1'
      #   '';
      #   end = ''
      #     nvidia-settings -a '[gpu:0]/GPUPowerMizerMode=0'
      #   '';
      # };
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
    openvpn
    networkmanager-openvpn
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
      xdg-desktop-portal-gtk
      # (xdg-desktop-portal-gtk.override {
      #   buildPortalsInGnome = false;
      # })
    ];
    config.common.default = "*";
  };
  hardware.graphics = {
    enable = true;
    # driSupport = true;
    # driSupport32Bit = true;
  };

  security.pam.services.swaylock = {};

  # nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #   "nvidia-settings"
  #   "nvidia-x11"
  #   "nvidia-persistenced"
  #   "steam"
  #   "steam-original"
  #   "steam-run"
  #   "libXNVCtrl"
  #   "hplip"
  #   "steam-unwrapped"
  #   "cuda-merged"
  # ];
  nixpkgs.config.allowUnfree = true;

  hardware.enableRedistributableFirmware = true;

  zramSwap = {
    enable = true;
    memoryMax = 4 * 1024 * 1024 * 1024;
  };

  # services.udev.packages = [ pkgs.platformio ];
  services.fstrim.enable = true;
  services.udisks2.enable = true;

  programs.kdeconnect = {
    enable = true;
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  services.flatpak.enable = true;

  boot.kernel.sysctl."kernel.sysrq" = 1;

  system.activationScripts.binbash = ''
    mkdir -m 755 -p /bin
    ln -sfn ${pkgs.bash}/bin/bash /bin/bash
  '';

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
