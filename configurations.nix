[
  {
    hostname = "NixPC";
    osConfigs = [
      ./profile/NixPC/os.nix
    ];
    overlays = [
      (import ./overlays/rtl-sdr-overlay.nix)
    ];
    users = [
      {
        username = "patryk";
        homeDirectory = "/home/patryk";
        homeManagerConfigs = [
          ./profile/NixPC/hm.nix
        ];
        groups = [ "wheel" "networkmanager" "video" "dialout" "docker" "cdrom" "plugdev" "realtime" ];
        trustedUser = true;
      }
    ];
  }
  {
    hostname = "Laptop-NixOS";
    osConfigs = [
      ./profile/Laptop-NixOS/os.nix
    ];
    overlays = [
      (import ./overlays/rtl-sdr-overlay.nix)
    ];
    users = [
      {
        username = "patryk";
        homeDirectory = "/home/patryk";
        homeManagerConfigs = [
          ./profile/Laptop-NixOS/hm.nix
        ];
        groups = [ "wheel" "networkmanager" "video" "dialout" "docker" "cdrom" ];
        trustedUser = true;
      }
    ];
  }
]
