{ inputs, ... }@topLevel:
{

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
      programs.kitty = {
        enable = true;
        extraConfig = ''
          dynamic_background_opacity yes

          # Do these do anything??
          shell_integration no-cursor
          cursor_shape block

          window_padding_width 15
          enable_audio_bell no

          confirm_os_window_close -1 count-background

          tab_bar_edge top

          tab_bar_margin_width 0.0
          tab_bar_margin_height 0.0 0.0

          tab_bar_style fade
          # tab_bar_style powerline
          # tab_powerline_style round


          map ctrl+shift+w close_window_with_confirmation ignore-shell
          map ctrl+shift+t new_tab_with_cwd

          # Toggle Opacity
          background_opacity 0.8
          map ctrl+shift+o kitten ~/.config/kitty/opacity.py
          '';
      };

      home.file = {
        ".config/kitty/opacity.py" = {
          source = ./opacity.py;
        };
      };


      # programs.wezterm = {
      #   enable = true;
      #   extraConfig = /* lua */ ''
      #     local wezterm = require 'wezterm'
      #     local handle = io.popen("echo $XDG_SESSION_TYPE")
      #     local result = handle:read("*a")
      #     handle:close()
      #
      #     return {
      #       font = wezterm.font 'FiraCode Nerd Font Mono',
      #            use_fancy_tab_bar = false,
      #            hide_tab_bar_if_only_one_tab = true,
      #            window_decorations = (result == "wayland\n") and "NONE" or "RESIZE",
      #            window_padding = {
      #              left    = 15,
      #              right   = 15,
      #              top     = 15,
      #              bottom  = 15,
      #            },
      #            adjust_window_size_when_changing_font_size = false,
      #            window_background_opacity = 0.8,
      #            text_background_opacity = 1.0,
      #            front_end = "WebGpu",
      #     }
      #   '';
      # };

    };
}
