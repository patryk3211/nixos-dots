{ config, pkgs, ... }:

{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  users.users.${config.profile.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "dialout" "docker" "cdrom" ];
  };

  environment.pathsToLink = [ "/share/zsh" ];

  security.sudo = {
    enable = true;
    extraConfig = ''
      user ALL=(ALL) ${pkgs.iproute2}/bin/ip netns
    '';
  };
}
