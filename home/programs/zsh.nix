{ config, pkgs, ... }: {
  programs.zsh =  {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;

    shellAliases = {
      nixos-update = "sudo nixos-rebuild switch --flake /.nixcfg";
      hm-update = "home-manager switch --flake /.nixcfg";
      ll = "ls -lah";
      icat = "kitty +kitten icat";
      hm = "home-manager";
      ssh = "kitty +kitten ssh";
    };

    plugins = [
      {
        name = "powerlevel10k";
        file = "powerlevel10k.zsh-theme";
        src = pkgs.fetchFromGitHub {
          owner = "romkatv";
          repo = "powerlevel10k";
          rev = "v1.19.0";
          sha256 = "15wp774bhyzpgk0l0lgsc1zak7m1nslrp1xisqqbsppbnr4y677s";
        };
      }
    ];

    initExtra = ''
      source ~/.p10k.zsh
    '';
  };
}
