{ options, config, pkgs, ... }:

{
  programs.git.signing = {
    signByDefault = true;
    key = "B6D04B0A52E0AFF3";
  };

  imports = [
    ./programs
    ./wm.nix
  ];

  # home.file.".xinitrc".text = ''
  #   exec twm
  # '';
}
