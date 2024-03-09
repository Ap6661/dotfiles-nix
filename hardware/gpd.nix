{ pkgs, nixos-hardware, ... }:
{
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.xserver.displayManager.sessionCommands = ''
  keyboardId=$(
    ${pkgs.xorg.xinput}/bin/xinput list 'HAILUCK CO.,LTD USB KEYBOARD' --id-only
    )
    if [[ $keyboardId ]]; then 
      ${pkgs.xorg.setxkbmap}/bin/setxkbmap -device $keyboardId -option ctrl:swapcaps
    fi
  '';
}
