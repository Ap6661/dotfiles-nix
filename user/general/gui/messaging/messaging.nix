{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.messaging;
in
{
  options.messaging = {
    enable = mkEnableOption "messaging";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (discord.override { withOpenASAR = true; withVencord = true; })
      telegram-desktop
    ];
  };
}
