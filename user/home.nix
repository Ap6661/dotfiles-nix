{ pkgs, config, home-manager, ... }: 
{
    home.stateVersion = "23.11";
    fonts.fontconfig.enable = true;

    /* Here be ~Dragons~ packages */
    home.packages = [
      (pkgs.nerdfonts.override { fonts = [ "Hack" "FiraCode" ]; } )
        pkgs.btop
        pkgs.discord
        pkgs.telegram-desktop
    ];

    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Macchiato-Compact-Mauve-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "mauve" ];
          size = "compact";
          tweaks = [ "rimless" "black" ];
          variant = "macchiato";
        };
      };
    };



    ## Configure the files!
    home.file = {
      ".wezterm.lua".source = ./wezterm.lua; 
    ##".config/sway/config".source = ./sway;
      ".background".source = ./background;
      ".config/btop" = {
        source = ./btop;
        recursive = true;
      };
    };
}
