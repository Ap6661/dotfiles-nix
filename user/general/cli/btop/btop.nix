{ lib, config, pkgs, ...}:
with lib;
let 
  cfg = config.btop;
in {
  options.btop = {
    enable = mkEnableOption "btop";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      btop
    ];

    home-manager.users.apnda.home.file = {
      ".config/btop" = {
        source = ./config; 
        recursive = true;
      };
    };
  };
}
