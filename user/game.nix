{ pkgs, ... }: 
{
  environment.systemPackages = with pkgs; [
    lutris
    itch
    wineWowPackages.stable
    winetricks
  ];
}
