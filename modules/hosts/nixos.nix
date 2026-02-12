{ inputs, config, ...}:
let
  mkNixos = host: {
    system ? "x86_64-linux",
    user ? "apnda"
  }: 
  inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
    {
      config.custom.constants = {
        inherit host user;
      };
    }
      config.flake.nixosModules."host-${host}"
      config.flake.nixosModules.core
      config.flake.modules.homeManager.core
    ];
  };
in
{
  flake.nixosConfigurations = {
    nixos = mkNixos "nixos" {  };
    # vm = mkNixos "vm" {  };
  };
}
