{ lib, config, pkgs, ...}:
with lib;
let 
  cfg = config.btop;
in {
  options.nvim = {
    enable = mkEnableOption "btop";
  };
  config = mkIf cfg.enable {
    home.file = {
      ".config/btop" = {
        source = ./config; 
        recursive = true;
      };
    };
  };
}
