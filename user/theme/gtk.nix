{ lib, config, pkgs, home-manager, ... }:
with lib;
let
  cfg = config.gtk-theme;
in
{
  options.gtk-theme = {
    enable = mkEnableOption "gtk-theme";
  };
  config = mkIf cfg.enable {
    home-manager.users.apnda.gtk = {
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

    home-manager.users.apnda.xdg.configFile = {
      "gtk-4.0/assets".source = "${config.home-manager.users.apnda.gtk.theme.package}/share/themes/${config.home-manager.users.apnda.gtk.theme.name}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source = "${config.home-manager.users.apnda.gtk.theme.package}/share/themes/${config.home-manager.users.apnda.gtk.theme.name}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${config.home-manager.users.apnda.gtk.theme.package}/share/themes/${config.home-manager.users.apnda.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    };
  };
}
