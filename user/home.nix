{ pkgs, config, home-manager, ... }:
{
  home.stateVersion = "23.11";
  fonts.fontconfig.enable = true;

  /* Here be ~Dragons~ packages */
  home.packages = [
    pkgs.nerd-fonts.hack
    pkgs.nerd-fonts.fira-code
  ];

  programs.mpv.enable = true;
  programs.firefox.enable = true;

  ## Configure the files!
  home.file = {
    # ".background".source = ./theme/background;
    ".background".source = config.stylix.image;
  };
}
