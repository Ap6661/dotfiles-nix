{ inputs, ... }@topLevel:
{
  flake.nixosModules.syncthing =
    {
      config,
      ...
    }:
    let
      inherit (config.custom.constants) user;
    in
    {
      imports = [ inputs.sops.nixosModules.sops ];

      services.syncthing = {
        enable = true;
        overrideDevices = false;
        overrideFolders = false;
      };
    };
}

