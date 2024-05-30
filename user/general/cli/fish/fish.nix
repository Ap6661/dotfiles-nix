{ lib, config, pkgs, home-manager, ... }:
with lib;
let
  cfg = config.fish;
in
{
  options.fish = {
    enable = mkEnableOption "fish";
  };
  config = mkIf cfg.enable {

    users.users.apnda.shell = pkgs.fish;
    programs.fish.enable = true;

    home-manager.users.apnda.home = {

      packages = [ pkgs.eza ];

      file = {
        ".config/fish/functions/fish_prompt.fish".source = ./prompt.fish;
        ".config/fish/config.fish".source = ./config.fish;
      };
    };
  };
}
