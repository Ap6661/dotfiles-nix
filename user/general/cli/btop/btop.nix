{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.btop;
in
{
  options.btop = {
    enable = mkEnableOption "btop";
  };
  config = mkIf cfg.enable {
    home-manager.users.apnda.programs.btop.enable = true;
  };
}
