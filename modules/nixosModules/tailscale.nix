{ ... }:
{

  flake.nixosModules.tailscale =
    { pkgs, ... }:
    {
      services.tailscale.enable = true;
    };
}
