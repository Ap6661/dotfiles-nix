{ ... }:
{
  flake.nixosModules.notifications = 
  { ... }: 
  {
    services.dunst = {
      enable = true;
    };
  };
}
