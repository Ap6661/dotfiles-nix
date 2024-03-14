{ lib, config, pkgs, home-manager, ...}:
with lib;
let 
  cfg = config.nvim;
in {
  options.nvim = {
    enable = mkEnableOption "nvim";
  };
  config = mkIf cfg.enable {
    
    environment.systemPackages = with pkgs; [
      neovim
        lazygit
        wget
        git
          gh
        gcc
        ripgrep
        fd
    ];
    home-manager.users.apnda.home.file = {
      ".config/nvim" = {
      	source = ./dotfiles-nvim;
        recursive = true;
      }; 
    };

  };
}
