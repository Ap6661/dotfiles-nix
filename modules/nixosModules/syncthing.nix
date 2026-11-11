{ inputs, ... }@topLevel:
{
  flake.nixosModules.syncthing =
    {
      pkgs,
      ...
    }:
    {
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

