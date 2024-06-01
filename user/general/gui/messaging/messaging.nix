{ lib, config, pkgs, ... }:
let
  cfg = config.messaging;
in
{
  options.messaging = {
    enable = lib.mkEnableOption "messaging";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.discord.override { withOpenASAR = true; withVencord = true; })
      pkgs.telegram-desktop
    ];
  };
}
