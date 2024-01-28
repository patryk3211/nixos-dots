{ config, pkgs, ... }:

{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment.pathsToLink = [ "/share/zsh" ];

  security.sudo = {
    enable = true;
    extraConfig = ''
      user ALL=(ALL) ${pkgs.iproute2}/bin/ip netns
    '';
  };
}
