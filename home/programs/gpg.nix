{ ... }:

{
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    pinentryFlavor = "curses";
  };
}
