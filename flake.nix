{
  description = "My NixOS Configuration";

  inputs = 
  {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixos-hardware, ... }: 
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
            nixos-hardware.nixosModules.framework-13th-gen-intel
          ];
        };
      };
    };
}
