{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kalker
    file-roller
    nautilus
    btop
    vlc
    # image-roll
    eog
    mate.atril
  ];

  # imports = [
  #   flake.inputs.nix-index-database.hmModules.nix-index
  # ];

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    bat.enable = true;
    nix-index = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
