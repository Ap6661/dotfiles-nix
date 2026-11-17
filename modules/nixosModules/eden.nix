{ inputs, ... }:
{
  flake.nixosModules.eden =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [ inputs.eden.overlays.default ];

      imports = [ inputs.eden.nixosModules.default ];

      programs.eden.enable = true;
    };
}
