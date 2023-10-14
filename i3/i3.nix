{ lib, config, pkgs, ...}:
with lib;
let 
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
  cfg = config.i3;
in {
  options.i3 = {
    enable = mkEnableOption "i3";
  };
  config = mkIf cfg.enable {

    services.xserver = {
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        extraPackages = with pkgs; [
            nitrogen
            dmenu
            i3lock
            i3status
            xclip
        ];
      };
    };

    home-manager.users.apnda.home.file = {
      ".config/i3/config".source = ./config;
      ".config/nitrogen" = {
        source = ./nitrogen;
        recursive = true;
      };
    };

  };
}
