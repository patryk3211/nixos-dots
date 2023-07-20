{ config, pkgs, ... }:

{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  users.users.${config.profile.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "dialout" ];
  };

  environment.pathsToLink = [ "/share/zsh" ];
}
