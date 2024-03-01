{ pkgs, nixos-hardware, ... }:
{

  imports = [
    nixos-hardware.nixosModules.framework-13th-gen-intel
  ];


  powerManagement.enable = true;


  boot.kernelParams = [ "resume=/swapfile" "resume_offset=423411712" ];
  boot.resumeDevice = "/dev/disk/by-uuid/79bcf5e9-d6b7-4b39-b509-41336f8fbd55";
  security.protectKernelImage = false;


  services.logind = {
    powerKey = "suspend";
    lidSwitch = "suspend";
  };


  ## 
  ## no caps lock on keyboard but only on embeded keyboard
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
