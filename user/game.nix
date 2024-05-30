{ pkgs, ... }:
{
  nixpkgs.config.allowBroken = true;
  environment.systemPackages = with pkgs; [
    lutris
    itch
    wineWowPackages.stable
    winetricks
  ];
}
