{ config, pkgs, lib, ... }: let
  addKeys = [ "git" ];
in {
  services.ssh-agent = {
    enable = true;
  };

  systemd.user.services.ssh-add-keys = let
    scriptSrc = "for key in ${lib.concatStringsSep " " addKeys}; do ${pkgs.openssh}/bin/ssh-add ${config.home.homeDirectory}/.ssh/$key; done";
  in {
    Unit = {
      Description = "Add keys to ssh agent";
      Requires = [ "ssh-agent.service" ];
      After = [ "ssh-agent.service" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "oneshot";
      Environment = "SSH_AUTH_SOCK=/run/user/1000/ssh-agent";
      ExecStart = "${pkgs.bash}/bin/bash -c '${scriptSrc}'";
    };
  };
}
