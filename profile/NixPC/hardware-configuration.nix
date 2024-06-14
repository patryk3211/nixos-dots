# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }: let
  bootId = "93C8-09FE";
  rootId = "075bd2b7-423a-4267-8988-122bc9052a65";
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.blacklistedKernelModules = [ "dvb_usb_rtl28xxu" ];
  boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelParams = [ "nvidia_drm.fbdev=1" ];

  boot.loader = {
    systemd-boot = {
      enable = lib.mkForce true;
      consoleMode = "max";
    };
    efi.canTouchEfiVariables = true;
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/${rootId}";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" "relatime" ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/${rootId}";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" "relatime" ];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/${rootId}";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "relatime" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/${bootId}";
      fsType = "vfat";
    };

    "/windrive" = {
      device = "/dev/disk/by-uuid/A0DCCC38DCCC0A8C";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" ];
    };
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  environment.systemPackages = with pkgs; [
    mesa
    nvidia-vaapi-driver
  ];

  # This is needed for Hyprland to work
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.opengl = {
    extraPackages = with pkgs; [ vaapiVdpau ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;

    open = false;
    nvidiaSettings = false;

    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  hardware.rtl-sdr.enable = true;
}
