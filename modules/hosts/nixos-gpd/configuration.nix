{ inputs, self, ... }@topLevel:
{
  flake.nixosModules.host-gpd =
    { pkgs, config, ... }:
    let
      inherit (config.custom.constants) user;
    in
    {

      imports =
        with topLevel.config.flake.nixosModules;
      [
        games
          i3
          sddm
          messaging
          # japanese
          virt
          # tailscale
          # syncthing

          inputs.nixos-hardware.nixosModules.framework-13th-gen-intel
      ]
      ++ [
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.users.${user} = {
          imports = with topLevel.config.flake.homeModules; [
            browser
# passwordManager
          ];
        };
      }
      ];

      powerManagement.enable = true;

      security.protectKernelImage = false;

      hardware.bluetooth.enable = true;
      services.blueman.enable = true;

      services.xserver.displayManager.sessionCommands = ''
        keyboardId=$(
            ${pkgs.xorg.xinput}/bin/xinput list --id-only 'HAILUCK CO.,LTD USB KEYBOARD'
            )
        if [[ $keyboardId ]]; then 
          ${pkgs.xorg.setxkbmap}/bin/setxkbmap -device $keyboardId -option ctrl:swapcaps
            fi
            '';

    };
}
