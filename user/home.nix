{ pkgs, config, home-manager, ... }:
{
  home.stateVersion = "23.11";
  fonts.fontconfig.enable = true;

  /* Here be ~Dragons~ packages */
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "Hack" "FiraCode" ]; })
  ];


  ## GTK Theme 

  ## Configure the files!
  home.file = {
    ".background".source = ./theme/background;
  };
}
