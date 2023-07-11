{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;

    userName = "patryk3211";
    userEmail = "patrykmierzy@gmail.com";
  };
}
