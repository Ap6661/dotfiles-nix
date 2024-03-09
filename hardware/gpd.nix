{ pkgs, nixos-hardware, ... }:
{
  hardware.bluetooth.enable = true;

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
