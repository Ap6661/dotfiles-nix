{ lib, config, pkgs, home-manager, ... }:
let
  cfg = config.zsh;
in
{
  options.zsh = {
    enable = lib.mkEnableOption "zsh";
  };
  config = lib.mkIf cfg.enable {

    users.users.apnda.shell = pkgs.zsh;
    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
        shellAliases = {
          ls = "eza";
        };
        ohMyZsh = {
          enable = true;
          plugins = [ "git" ];
          theme = "fino-time";
        };
      };
    };

    environment.pathsToLink = [ "/share/zsh" ];

    home-manager.users.apnda.home = {
      packages = with pkgs; [ eza ];
      file.".zshrc".source = ./.zshrc;
    };
  };
}
