{ lib, ... }:
{
  flake.nixosModules.core = { config, ... }:
    let
    inherit (config.custom.constants) user;
  in
  {
    config = lib.mkMerge [
    {
      users = {
        users = {
          ${user} = {
            isNormalUser = true;
            extraGroups = [
              "networkmanager"
                "wheel"
                "dialout"
            ];
            initialPassword = "ChangeMe";
          };
          # root = {
          #   initialPassword = "password";
          # };
        };
      };
    }
    ];
  };
}
