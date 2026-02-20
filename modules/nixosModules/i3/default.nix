{ inputs, ... }@topLevel:
{
  flake.nixosModules.i3 =
    {
      lib,
      pkgs,
      config,
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
              i3
              launcher
            ];
          };
        }
      ]
      ++ (with topLevel.config.flake.nixosModules; [
        terminal
      ]);

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

            libqalculate

            picom
            brightnessctl
            flameshot
          ];
        };
      };
    };
}
