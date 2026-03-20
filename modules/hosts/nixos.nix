{ inputs, config, ... }:
let
  mkNixos =
    host:
    {
      system ? "x86_64-linux",
      user ? "apnda",
      isVm ? false,
    }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        {
          config.custom.constants = {
            inherit host user isVm;
          };
        }
        config.flake.nixosModules."host-${host}"
        config.flake.nixosModules.core
        config.flake.nixosModules.shell

        inputs.nvim.nixosModules.nvim

        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${user} = {
            imports = [
              {
                config.custom.constants = {
                  inherit host user isVm;
                };
              }
              config.flake.homeModules."host-${host}"
              config.flake.homeModules.core
            ];
          };
        }
      ];

    };
    mkVm = host: args: mkNixos host ( args // { isVm = true; });
in
{
  flake.nixosConfigurations = {
    nixos = mkNixos "nixos" { };
    desktop = mkNixos "desktop" { };

    nixos-vm = mkVm "nixos" {  };
  };
}
