{
  inputs,
  ...
}:
{
  imports = [ inputs.home-manager.flakeModules.home-manager ];

  flake.homeModules.core =
    {
      config,
      ...
    }:
    let
      inherit (config.custom.constants) user;
    in
    {
      xdg.configHome = "/home/${user}/.config";

      home.stateVersion = "23.11";
    };

}
