{
  pkgs,
  config,
  home-manager,
  inputs,
  ...
}:
{
  home.stateVersion = "23.11";
  fonts.fontconfig.enable = true;

  # Here be ~Dragons~ packages
  home.packages = [
    pkgs.nerd-fonts.hack
    pkgs.nerd-fonts.fira-code
  ] ++ (with inputs.nixos-fonts.packages.x86_64-linux; [
    azukifont
  ]);

  services.flameshot = {
    enable = true;
    settings = {
      General = { 
        useGrimAdapter = true;
      };
    };
  }; 

  programs.mpv = {
    enable = true;
    package = (pkgs.mpv-unwrapped.override {
        sixelSupport = true;
      });
  };

  programs.firefox = {
    enable = true;
    profiles = {
      "main" = {
        name = "main";
        extensions = {
          force = true;
          packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
            darkreader
            ublock-origin
            proton-pass
            sponsorblock
          ];
          settings = {
            "FirefoxColor@mozilla.com".force = true;
          };
        };

        search = {
          force = true;
          default = "ddg";
        };

        settings = {
          "full-screen-api.ignore-widgets" = true;
          "browser.tabs.closeWindowWithLastTab" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.showSearch" = false;
          "browser.newtabpage.activity-stream.showWeather" = false;
          "extensions.autoDisableScopes" = 0;

          # Disable password saving 
          "signon.rememberSignons" = false;

          # privacy
          "browser.search.suggest.enabled" = false;
          "privacy.annotate_channels.strict_list.enabled" = true;
          "privacy.clearOnShutdown_v2.cookiesAndStorage" = true;
          "datareporting.healthreport.uploadEnabled" = false;
        };
      };
    };
  };
  stylix.targets.firefox = {
    colorTheme.enable = true;
    profileNames = [ "main" ];
  };

  ## Configure the files!
  home.file = {
    # ".background".source = ./theme/background;
    ".background".source = config.stylix.image;
  };
}
