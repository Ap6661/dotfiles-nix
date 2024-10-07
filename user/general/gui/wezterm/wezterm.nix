{ lib, config, pkgs, home-manager, ... }:
let
  cfg = config.wezterm;
in
{
  options.wezterm = {
    enable = lib.mkEnableOption "wezterm";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (nerdfonts.override { fonts = [ "Hack" "FiraCode" ]; })
    ];
    home-manager.users.apnda = {
      programs.wezterm = {
        enable = true;
        extraConfig = /*lua*/ ''
          local wezterm = require 'wezterm'
          return {
            font = wezterm.font 'FiraCode Nerd Font Mono',
                 use_fancy_tab_bar = false,
                 hide_tab_bar_if_only_one_tab = true,
                 window_decorations = "RESIZE",
                 window_padding = {
                   left    = 15,
                   right   = 15,
                   top     = 15,
                   bottom  = 15,
                 },
                 adjust_window_size_when_changing_font_size = false,
                 window_background_opacity = 0.8,
                 text_background_opacity = 1.0,
                 front_end = "WebGpu",
          }
        '';
      };
    };
  };
}
