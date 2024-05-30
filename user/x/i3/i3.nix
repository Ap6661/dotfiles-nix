{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.i3;
in
{
  options.i3 = {
    enable = mkEnableOption "i3";
  };
  config = mkIf cfg.enable {

    services.xserver = {
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3;
        extraPackages = with pkgs; [
          nitrogen
          i3lock
          xclip

          eww
          wmctrl
          beats
          i3status

          picom

          xborders
          libnotify

          brightnessctl
          flameshot
        ];
      };
    };


    home-manager.users.apnda.home.file = {
      ".config/i3/config".source = ./i3/config;
      ".config/picom".source = ./picom;
      ".config/nitrogen" = {
        source = ./nitrogen;
        recursive = true;
      };
      ".config/eww" = {
        source = ./eww/config;
        recursive = true;
      };
      ".xsession".source = ./.xsession;
    };

  };
}
