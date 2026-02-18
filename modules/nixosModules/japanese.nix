{ inputs, ... }@topLevel:
{

  flake.nixosModules.japanese =
    {
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
              japanese
            ];
          };
        }
      ];

      i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5 = {
          addons = with pkgs; [
            fcitx5-mozc-ut
          ];
          settings.inputMethod = {
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "us";
              DefaultIM = "mozc";
            };
            "Groups/0/Items/0".Name = "keyboard-us";
            "Groups/0/Items/1".Name = "mozc";
          };
        };
      };

      environment.systemPackages = with pkgs; [
        (anki.withAddons [
          ankiAddons.passfail2
          (anki-utils.buildAnkiAddon (finalAttrs: {
            pname = "MoreOverviewStats";
            version = "v2.1.36";
            src = fetchFromGitHub {
              owner = "patrick-mahnkopf";
              repo = "Anki_More_Overview_Stats";
              rev = "v2.1.36";
              sha256 = "Mt6EqFmQChgOf7Y/JufFoL/fgpl5yBoqiyULlAbLqrE=";
            };
          }))
          (anki-utils.buildAnkiAddon (finalAttrs: {
            pname = "ProgressStats";
            version = "v0.13";
            src = fetchFromGitHub {
              owner = "matthayes";
              repo = "anki_progress_stats";
              rev = "v0.13";
              sha256 = "KR9DUTUQ5U++WCgCvPK89/BP60KMnxmzKXCUIFEMkqo=";
            };
          }))
        ])
      ];
    };

  flake.homeModules.japanese =
    {
      pkgs,
      ...
    }:
    {
      programs.firefox = {
        profiles."main".extensions.packages =
          with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
            yomitan
          ];
      };

      home.packages = [
        pkgs.noto-fonts-cjk-sans
      ];
    };
}
