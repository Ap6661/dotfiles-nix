{ pkgs, ... }:
{
  nixpkgs.config.allowBroken = true;
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    lutris
    # itch
    wineWowPackages.stable
    winetricks
  ];
}
