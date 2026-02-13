{
  flake.homeModules.launcher = 
  {
    pkgs,
    ...
  }: {
    programs.rofi = {
      enable = true;
      plugins = [ pkgs.rofi-emoji ];
    };

    home.file = {
      ".config/rofi" = {
        source = ./config;
        recursive = true;
      };
    };
  };
}
