{ inputs, ... }@topLevel:
{
  flake.nixosModules.shell = 
  {
  config,
  pkgs,
  ...
  }: 
  let
    inherit (config.custom.constants) user;
  in
  {
    imports = [
      inputs.home-manager.nixosModules.home-manager 
      {
        home-manager.users.${user} = {  
          imports = with topLevel.config.flake.homeModules; [ 
            shell
          ];
        };
      }
    ];

    users.users.${user}.shell = pkgs.zsh;
    programs.zsh.enable = true;

  };

  flake.homeModules.shell = 
  {
    config,
    pkgs,
    ...
  }:
  {
    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        shellAliases = {
          ls = "eza";
        };
        oh-my-zsh = {
          enable = true;
          plugins = [ "git" ];
          theme = "fino-time";
        };
      };
    };

    home = {
      packages = with pkgs; [ eza ];
      # file.".zshrc".source = ./.zshrc;
    };
    
  };
}
