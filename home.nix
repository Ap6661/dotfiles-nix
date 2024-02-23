{ pkgs, config, home-manager, ... }: 
{
    home.stateVersion = "23.11";
    fonts.fontconfig.enable = true;

    /* Here be ~Dragons~ packages */
    home.packages = [
      (pkgs.nerdfonts.override { fonts = [ "Hack" ]; } )
        pkgs.htop
        pkgs.discord
    ];

    ## Configure the files!
    home.file = {
      ".wezterm.lua".source = ./wezterm.lua; 
    ##".config/sway/config".source = ./sway;
      ".background".source = ./background;
  };
}
