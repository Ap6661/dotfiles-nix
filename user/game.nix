{ pkgs, ... }:
{
  nixpkgs.config.allowBroken = true;
  programs.steam.enable = true;
  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];
  environment.systemPackages = with pkgs; [
    lutris
    # itch
    wineWowPackages.stable
    winetricks
  ];
}
