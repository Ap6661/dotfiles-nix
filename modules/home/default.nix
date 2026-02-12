{ 
  inputs,
    ...
}: 
{
  imports = [ inputs.home-manager.flakeModules.home-manager ];

  flake.modules.homeManager.core = 
  { 
    pkgs,
    ...
  }: {

    programs.wezterm.enable = true;
    home.stateVersion = "23.11";
  };

}
