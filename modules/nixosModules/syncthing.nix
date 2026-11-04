{ inputs, ... }@topLevel:
{
  flake.nixosModules.syncthing =
    {
      config,
      pkgs,
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
        systemService = false;
      };

      systemd.user.services.user-syncthing = {
        enable = true;
        wantedBy = [ "default.target" ];
        description = "Run Syncthing as User";
        serviceConfig = {
          ExecStart = ''${pkgs.syncthing}/bin/syncthing'';
        };
      };
    };
}

