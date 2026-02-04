{
  description = "My NixOS Configuration";

  inputs =
    {
      nixpkgs.url = "nixpkgs/nixos-unstable";

      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nixos-hardware.url = "github:NixOS/nixos-hardware/master";

      stylix = {
        url = "github:danth/stylix";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      firefox-addons = {
        url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nvim = {
        url = "github:ap6661/dotfiles-nvim";
        inputs = {
          nixpkgs.follows = "nixpkgs";
          home-manager.follows = "home-manager";
        };
      };
    };

  outputs = { nixpkgs, home-manager, nixos-hardware, nvim, ... }@inputs:
    {
      nixosConfigurations =
        let
          lib = nixpkgs.lib;
        in
        {
          nixos = lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit nixos-hardware;
              inherit home-manager;
              inherit inputs;
            };
            modules = [
              ./configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  extraSpecialArgs = { inherit inputs; };
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.apnda = import ./user/home.nix;
                };
              }
              ./hardware/framework.nix
              ./hardware-configuration/framework.nix
              ./user/game.nix
              inputs.nvim.nixosModules.nvim
              inputs.stylix.nixosModules.stylix
            ];
          };
          nixos-gpd = lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit nixos-hardware;
              inherit home-manager;
              inherit inputs;
            };
            modules = [
              ./configuration.nix
              inputs.nvim.nixosModules.nvim
              inputs.stylix.nixosModules.stylix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  extraSpecialArgs = { inherit inputs; };
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.apnda = import ./user/home.nix;
                };
              }
              ./hardware/gpd.nix
              ./hardware-configuration/gpd.nix
              ./user/game.nix
            ];
          };
          nixos-desktop = lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              inherit nixos-hardware;
              inherit home-manager;
              inherit inputs;
            };
            modules = [
              ./configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  extraSpecialArgs = { inherit inputs; };
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.apnda = import ./user/home.nix;
                };
              }
              ./hardware-configuration/desktop.nix
              ./hardware/desktop.nix
              ./user/game.nix
              inputs.nvim.nixosModules.nvim
              inputs.stylix.nixosModules.stylix
            ];
          };
        };
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
