{ lib, config, pkgs, ...}:
with lib;
let 
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
  cfg = config.nvim;
in {
  options.nvim = {
    enable = mkEnableOption "nvim";
  };
  config = mkIf cfg.enable {
    
    environment.systemPackages = with pkgs; [
      pkgs.neovim
        pkgs.neovim-gtk
        pkgs.lazygit
        pkgs.wget
        pkgs.git
        pkgs.gh
        pkgs.gcc
    ];
    home-manager.users.apnda.home.file = {
      ".config/nvim" = {
      	source = ./dotfiles-nvim;
        recursive = true;
      }; 
    };

  };
}
