{
  description = "My NixOS Configuration";

  inputs = 
  {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: 
    {
      nixosConfigurations = 
      let 
        lib = nixpkgs.lib;
      in {
        nixos = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ 
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.apnda = import ./home.nix;
            }
          ] ++ lib.optional (builtins.pathExists ./local/configuration.nix) ./local/configuration.nix;
        };
      };
    };
}
