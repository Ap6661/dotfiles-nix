{ pkgs, config, home-manager, ... }:
{
  home.stateVersion = "23.11";
  fonts.fontconfig.enable = true;

  /* Here be ~Dragons~ packages */
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "Hack" "FiraCode" ]; })
  ];

  programs.mpv.enable = true;
  programs.firefox.enable = true;

  ## Configure the files!
  home.file = {
    ".background".source = ./theme/background;
  };
}
