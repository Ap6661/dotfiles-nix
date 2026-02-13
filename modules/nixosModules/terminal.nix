{inputs, ...}@topLevel: {
  
  flake.nixosModules.terminal = 
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
            terminal 
          ];
        };
      }
    ];

    fonts.packages = with pkgs.nerd-fonts; [
      fira-code
      hack
    ];
  };

  flake.homeModules.terminal = 
  {
    ...
  }:
  {
      programs.wezterm = {
        enable = true;
        extraConfig = /*lua*/ ''
          local wezterm = require 'wezterm'
          local handle = io.popen("echo $XDG_SESSION_TYPE")
          local result = handle:read("*a")
          handle:close()

          return {
            font = wezterm.font 'FiraCode Nerd Font Mono',
                 use_fancy_tab_bar = false,
                 hide_tab_bar_if_only_one_tab = true,
                 window_decorations = (result == "wayland\n") and "NONE" or "RESIZE",
                 window_padding = {
                   left    = 15,
                   right   = 15,
                   top     = 15,
                   bottom  = 15,
                 },
                 adjust_window_size_when_changing_font_size = false,
                 window_background_opacity = 0.8,
                 text_background_opacity = 1.0,
                 front_end = "WebGpu",
          }
        '';
      };

  };
}
