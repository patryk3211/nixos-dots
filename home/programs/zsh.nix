{ config, pkgs, ... }: {
  home.shellAliases = {
    nixos-update = "sudo nixos-rebuild switch --flake /.nixcfg";
    hm-update = "home-manager switch --flake /.nixcfg";
    full-update = "pushd /.nixcfg && nix flake update && sudo nixos-rebuild switch --flake /.nixcfg && home-manager switch --flake /.nixcfg && popd";
    ll = "ls -lah";
    icat = "kitty +kitten icat";
    hm = "home-manager";
    ssh = "kitty +kitten ssh";
    nix-edit = "pushd /.nixcfg; lvim; popd";
  };

  programs.zsh =  {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

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

      setopt HIST_IGNORE_SPACE
      alias jrnl=" jrnl"
    '';
  };
}
