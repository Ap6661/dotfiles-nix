{ inputs, ...}@topLevel: 
{
  flake.nixosModules.i3 = 
  {
    lib,
    pkgs,
    ...
  }: {

    services.xserver = {
      enable = true;
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3.overrideAttrs (old: { 
            version = "4.25"; 
            src = pkgs.fetchFromGitHub {
            owner = "i3";
            repo = "i3";
            tag = "4.25";
            hash = "sha256-bkfuzy7ewHwA9GQNbUvZjQVCCYrnnm2Wf/htHRSkdzk=";
            };
            postPatch = ''
            patchShebangs .

            # This testcase generates a Perl executable file with a shebang, and
            # patchShebangs can't replace a shebang in the middle of a file.
            if [ -f testcases/t/318-i3-dmenu-desktop.t ]; then
            substituteInPlace testcases/t/318-i3-dmenu-desktop.t \
            --replace-fail "#!\$Config{perlpath}" "#!${lib.getExe pkgs.perl}"
            fi
            '';
            });

        extraPackages = with pkgs; [
          nitrogen
            i3lock
            xclip

            eww
            wmctrl
            beats
            i3status
            i3-swallow

            picom
            brightnessctl
            flameshot
        ];
      };
    };

  };

  # imports = with topLevel.config.flake.homeModules; [
  #   i3
  # ];
  #
  # flake.homeModules.i3 = 
  # {
  #   config,
  #   ...
  # }:
  # let 
  #   inherit (config.custom.constants) user;
  # in
  # {
  #   ## home-manager.users.apnda.home.file.".config/i3/config" 
  #   home-manager.users.${user}.home.file = {
  #     ".config/i3/config" = {
  #       text =
  #         ''
  #           set $base00 ${config.stylix.base16Scheme.base00}
  #           set $base01 ${config.stylix.base16Scheme.base01}
  #           set $base02 ${config.stylix.base16Scheme.base02}
  #           set $base03 ${config.stylix.base16Scheme.base03}
  #           set $base04 ${config.stylix.base16Scheme.base04}
  #           set $base05 ${config.stylix.base16Scheme.base05}
  #           set $base06 ${config.stylix.base16Scheme.base06}
  #           set $base07 ${config.stylix.base16Scheme.base07}
  #           set $base08 ${config.stylix.base16Scheme.base08}
  #           set $base09 ${config.stylix.base16Scheme.base09}
  #           set $base0A ${config.stylix.base16Scheme.base0A}
  #           set $base0B ${config.stylix.base16Scheme.base0B}
  #           set $base0C ${config.stylix.base16Scheme.base0C}
  #           set $base0D ${config.stylix.base16Scheme.base0D}
  #           set $base0E ${config.stylix.base16Scheme.base0E}
  #           set $base0F ${config.stylix.base16Scheme.base0F}
  #           ${(builtins.readFile ./i3/config) }
  #         '';
  #     };
  #     ".config/picom".source = ./picom;
  #     ".config/nitrogen" = {
  #       source = ./nitrogen;
  #       recursive = true;
  #     };
  #     ".config/eww" = {
  #       source = ./eww/config;
  #       recursive = true;
  #     };
  #     ".config/eww/stylix.scss".text = /* scss */ ''
  #       $base00: ${config.stylix.base16Scheme.base00};
  #       $base01: ${config.stylix.base16Scheme.base01};
  #       $base02: ${config.stylix.base16Scheme.base02};
  #       $base03: ${config.stylix.base16Scheme.base03};
  #       $base04: ${config.stylix.base16Scheme.base04};
  #       $base05: ${config.stylix.base16Scheme.base05};
  #       $base06: ${config.stylix.base16Scheme.base06};
  #       $base07: ${config.stylix.base16Scheme.base07};
  #       $base08: ${config.stylix.base16Scheme.base08};
  #       $base09: ${config.stylix.base16Scheme.base09};
  #       $base0A: ${config.stylix.base16Scheme.base0A};
  #       $base0B: ${config.stylix.base16Scheme.base0B};
  #       $base0C: ${config.stylix.base16Scheme.base0C};
  #       $base0D: ${config.stylix.base16Scheme.base0D};
  #       $base0E: ${config.stylix.base16Scheme.base0E};
  #       $base0F: ${config.stylix.base16Scheme.base0F};
  #     '';
  #   };
  #
  # };
}
