{ pkgs, ... }:
{
  imports = [
    "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/framework/13-inch/13th-gen-intel"
  ];
  services.fwupd.enable = true;


  virtualisation.docker.enable = true;
  users.users.apnda = {
    extraGroups = [
    "docker"
    ];
  };


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
