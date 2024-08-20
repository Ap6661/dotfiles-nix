{ lib, config, pkgs, ... }:
let
  cfg = config.i3;
in
{
  options.i3 = {
    enable = lib.mkEnableOption "i3";
  };
  config = lib.mkIf cfg.enable {

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

          # picom
          ( pkgs.callPackage ./picom.nix {  } )

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
        recursive = true; };
      ".config/eww/stylix.scss".text = /* scss */ ''
      $base00: ${config.stylix.base16Scheme.base00};
      $base01: ${config.stylix.base16Scheme.base01};
      $base02: ${config.stylix.base16Scheme.base02};
      $base03: ${config.stylix.base16Scheme.base03};
      $base04: ${config.stylix.base16Scheme.base04};
      $base05: ${config.stylix.base16Scheme.base05};
      $base06: ${config.stylix.base16Scheme.base06};
      $base07: ${config.stylix.base16Scheme.base07};
      $base08: ${config.stylix.base16Scheme.base08};
      $base09: ${config.stylix.base16Scheme.base09};
      $base0A: ${config.stylix.base16Scheme.base0A};
      $base0B: ${config.stylix.base16Scheme.base0B};
      $base0C: ${config.stylix.base16Scheme.base0C};
      $base0D: ${config.stylix.base16Scheme.base0D};
      $base0E: ${config.stylix.base16Scheme.base0E};
      $base0F: ${config.stylix.base16Scheme.base0F};
      '';
      ".config/i3/xborders.json".text = /* json */ ''
        {
          "border-rgba": "${config.stylix.base16Scheme.base0E}AA"
        }
      '';

      ".xsession".source = ./.xsession;
    };

  };
}
