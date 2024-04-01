{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kalker
    gnome.file-roller
    gnome.nautilus
    btop
    vlc
    image-roll
    gnome.eog
    mate.atril
  ];

  # imports = [
  #   flake.inputs.nix-index-database.hmModules.nix-index
  # ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    bat.enable = true;
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
