[
  {
    hostname = "NixPC";
    osConfigs = [
      ./profile/NixPC/os.nix
    ];
    users = [
      {
        username = "patryk";
        homeDirectory = "/home/patryk";
        homeManagerConfigs = [
          ./profile/NixPC/hm.nix
        ];
        groups = [ "wheel" "networkmanager" "video" "dialout" "docker" "cdrom" ];
        trustedUser = true;
      }
    ];
  }
  {
    hostname = "Laptop-NixOS";
    osConfigs = [
      ./profile/NixPC/os.nix
    ];
    users = [
      {
        username = "patryk";
        homeDirectory = "/home/patryk";
        homeManagerConfigs = [
          ./profile/Laptop-NixOS/os.nix
        ];
        groups = [ "wheel" "networkmanager" "video" "dialout" "docker" "cdrom" ];
        trustedUser = true;
      }
    ];
  }
]
