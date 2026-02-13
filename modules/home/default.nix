{ 
  inputs,
    ...
}: 
{
  imports = [ inputs.home-manager.flakeModules.home-manager ];

  flake.homeModules.core = 
  { 
    pkgs,
    ...
  }: {

    home.stateVersion = "23.11";
  };

}
