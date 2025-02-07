{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    libreoffice
    krita
    webcord
    thunderbird
    neovim
    discord
    # openjdk17
    zulu
    distrobox
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
    ./gpg.nix
    ./python.nix
  ];

  xdg.desktopEntries."bCNC.desktop" = {
    name = "bCNC";
    exec = "bCNC";
    icon = "bCNC";
    terminal = false;
  };

  xdg.desktopEntries."kalker" = {
    name = "Kalker";
    exec = "${pkgs.kalker}/bin/kalker";
    type = "Application";
    terminal = true;
    icon = "calc";
    settings = {
      Keywords = "Calculator;";
    };
  };
}
