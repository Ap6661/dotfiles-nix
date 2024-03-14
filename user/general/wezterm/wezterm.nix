{ lib, config, pkgs, ...}:
with lib;
let 
  cfg = config.wezterm;
in {
  options.nvim = {
    enable = mkEnableOption "wezterm";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (nerdfonts.override { fonts = [ "Hack" "FiraCode" ]; } )
        wezterm
    ];

    home.file = {
      ".wezterm.lua".source = ./wezterm.lua; 
    };
  };
}
