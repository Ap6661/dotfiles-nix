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

  /* Here be ~Dragons~ packages */
  # Here be ~Dragons~ packages
  home.packages = [
    pkgs.nerd-fonts.hack
    pkgs.nerd-fonts.fira-code
  ];

  programs.mpv = {
    enable = true;
    package = pkgs.mpv-unwrapped.wrapper {
      mpv = pkgs.mpv-unwrapped.override {
        sixelSupport = true;
      };
    };
  };

  programs.firefox = {
    enable = true;
    profiles = {
      "main" = {
        name = "main";
        extensions = {
          force = true;
          packages = with inputs.firefox-addons.packages.${pkgs.system}; [
            darkreader
            ublock-origin
            proton-pass
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
          "layout.css.devPixelsPerPx" = 1.5;
          "browser.tabs.closeWindowWithLastTab" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.showSearch" = false;
          "browser.newtabpage.activity-stream.showWeather" = false;

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
