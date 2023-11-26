{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    userName = "patryk3211";
    userEmail = "patrykmierzy@gmail.com";

    extraConfig.credential = {
      helper = "${pkgs.gitFull/* .override { withLibsecret = true; } */}/bin/git-credential-libsecret";
    };
  };
}
