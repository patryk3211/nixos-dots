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

  users.groups.realtime = { };
  services.udev.extraRules = ''
    KERNEL=="cpu_dma_latency", GROUP="realtime"
  '';
  security.pam.loginLimits = [
    {
      domain = "@realtime";
      type = "-";
      item = "rtprio";
      value = 98;
    }
    {
      domain = "@realtime";
      type = "-";
      item = "memlock";
      value = "unlimited";
    }
    {
      domain = "@realtime";
      type = "-";
      item = "nice";
      value = -11;
    }
  ];
}
