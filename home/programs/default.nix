{ config, pkgs, ... }: let
  bcnc = import ./bcnc.nix { inherit pkgs; fetchurl = pkgs.fetchurl; fetchhg = pkgs.fetchhg; };
in {
  home.packages = with pkgs; [
    libreoffice
    krita
    webcord
    thunderbird
    neovim
    discord
    (python311.withPackages(ps: [
      pkgs.python311Packages.cython
      (bcnc ps).bCNC
    ]))
  ];

  imports = [
    ./kitty.nix
    ./zsh.nix
    ./firefox.nix
    ./git.nix
    ./ssh-agent.nix
    ./keepass.nix
    ./3d.nix
    ./utilities.nix
#    ./nvim
  ];

  xdg.desktopEntries."bCNC.desktop" = {
    name = "bCNC";
    exec = "bCNC";
    icon = "bCNC";
    terminal = false;
  };
}
