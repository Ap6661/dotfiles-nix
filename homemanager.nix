{ pkgs, config, ...}:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];



  home-manager.users.apnda = {
      home.stateVersion = "23.05";
      programs.home-manager.enable = true;

      fonts.fontconfig.enable = true;

      /* Here be ~Dragons~ packages */
      home.packages = [
        (pkgs.nerdfonts.override { fonts = [ "Hack" ]; } )
        pkgs.htop
      ];

      ## Configure the files!
      home.file = {
      ".wezterm.lua".source = ./wezterm.lua; 
      ".config/sway/config".source = ./sway;
      ".background.jpg".source = ./background.jpg;
      ".config/nvim" = {
      	source = ./nvim;
        recursive = true;
      }; 
    };
  };
}
