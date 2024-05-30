{ lib, config, pkgs, home-manager, ... }:
with lib;
let
  cfg = config.wezterm;
in
{
  options.wezterm = {
    enable = mkEnableOption "wezterm";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (nerdfonts.override { fonts = [ "Hack" "FiraCode" ]; })
      wezterm
    ];

    home-manager.users.apnda.home.file = {
      ".wezterm.lua".source = ./wezterm.lua;
    };
  };
}
