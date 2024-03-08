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
        tweaks = [ "rimless" ];
        variant = "macchiato";
      };
    };
  };
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
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
