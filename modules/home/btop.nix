{ inputs, ... }:
{

  flake.homeModules.core = {
    programs.btop.enable = true;
  };

}
