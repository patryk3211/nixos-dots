{ config, pkgs, lib, ... }: let
  globalIgnore = pkgs.writeText "gitglobalignore" ''
    compile_commands.json
    .ccls-cache
    .cache
  '';
in {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    userName = "patryk3211";
    userEmail = "patrykmierzy@gmail.com";

    extraConfig = {
      credential.helper = "${pkgs.gitFull}/bin/git-credential-libsecret";
      core.excludesFile = "${globalIgnore}";
    };
  };
}
