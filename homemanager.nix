{ pkgs, config, ...}:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];



  home-manager.users.apnda = {
      home.stateVersion = "23.11";
      programs.home-manager.enable = true;

      fonts.fontconfig.enable = true;

      /* Here be ~Dragons~ packages */
      home.packages = [
        (pkgs.nerdfonts.override { fonts = [ "Hack" ]; } )
        pkgs.htop
        pkgs.discord
      ];

      ## Configure the files!
      home.file = {
      ".wezterm.lua".source = ./wezterm.lua; 
      ##".config/sway/config".source = ./sway;
      ".background".source = ./background;
    };
  };
}
