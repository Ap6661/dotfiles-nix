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
    powerKey = "hibernate";
    lidSwitch = "suspend";
  };


  ## 
  ## no caps lock on keyboard but only on embeded keyboard
  ## 
  ## As well as normal scrolling
  ## 
  services.xserver.displayManager.sessionCommands = ''
  keyboardId=$(
    ${pkgs.xorg.xinput}/bin/xinput list --id-only 'AT Translated Set 2 keyboard'
    )
    if [[ $keyboardId ]]; then 
      ${pkgs.xorg.setxkbmap}/bin/setxkbmap -device $keyboardId -option ctrl:nocaps
    fi

    ${pkgs.xorg.xinput}/bin/xinput set-prop PIXA3854:00\ 093A:0274\ Touchpad libinput\ Natural\ Scrolling\
 Enabled 1
  '';

}
