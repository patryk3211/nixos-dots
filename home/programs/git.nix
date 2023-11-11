{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    userName = "patryk3211";
    userEmail = "patrykmierzy@gmail.com";

    extraConfig.credential = {
      credentialStore = "secretservice";
      helper = "libsecret";
    };
  };
}
