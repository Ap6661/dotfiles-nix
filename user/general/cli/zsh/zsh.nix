{ lib, config, pkgs, home-manager, ... }:
let
  cfg = config.zsh;
in
{
  options.zsh = {
    enable = lib.mkEnableOption "zsh";
  };
  config = lib.mkIf cfg.enable {

    users.users.apnda.shell = pkgs.zsh;
    programs.zsh = {
      enable = true;
      ohMyZsh.enable = true;
      syntaxHighlighting.enable = true;
    };

    home-manager.users.apnda.home = {
      packages = with pkgs; [ 
        eza 
      ];
    };
  };
}
