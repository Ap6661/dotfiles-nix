{ pkgs, nixos-hardware, ... }:
{

  imports = [
    nixos-hardware.nixosModules.framework-13th-gen-intel
  ];

  ## 
  ## No caps lock on keyboard but only on embeded keyboard
  ## 
  services.xserver.displayManager.sessionCommands = ''
  keyboardId=$(
    ${pkgs.xorg.xinput}/bin/xinput |
      sed -nE 's/.*AT Translated Set 2 keyboard.*?id=([0-9]+).*/\1/p'
    )
    if [[ $keyboardId ]]; then 
      ${pkgs.xorg.setxkbmap}/bin/setxkbmap -device $keyboardId -option ctrl:nocaps
    fi
  '';
}
