{ ... }:
{

  flake.nixosModules.ratbag =
    {
      pkgs,
      ...
    }:
    {
      services.ratbagd.enable = true;
    };
}
