{ lib, config, pkgs, ...}:
with lib;
let 
  cfg = config.rofi;
in {
  options.nvim = {
    enable = mkEnableOption "rofi";
  };
  config = mkIf cfg.enable {

    environment.systemPackages = with pkgs; [
      xdotool # Depended by rofi-emoji
    ];

    home-manager.users.apnda.programs.rofi = {
      enable = true;
      plugins = [pkgs.rofi-emoji];
    };

    home-manager.users.apnda.home.file = {
      ".config/rofi" = {
        source = ./config;
        recursive = true;
      };
    };
  };
}
