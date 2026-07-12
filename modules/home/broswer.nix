{ inputs, ... }:
{

  flake.homeModules.browser =
    {
      pkgs,
      config,
      ...
    }:
    {
      programs.firefox = {
        enable = true;
        configPath = "${config.xdg.configHome}/mozilla/firefox";
        profiles = {
          "main" = {
            name = "main";
            extensions = {
              force = true;
              packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
                darkreader
                adnauseam # ublock-origin
                proton-pass
                sponsorblock
                youtube-shorts-block
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
              "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
              "datareporting.healthreport.uploadEnabled" = false;
              "datareporting.usage.uploadEnable" = false;

              # AI
              "browser.ai.control.default" = "blocked";
              "browser.ai.control.linkPreviewKeyPoints" = "blocked";
              "browser.ai.control.pdfjsAltText" = "blocked";
              "browser.ai.control.sidebarChatbot" = "blocked";
              "browser.ai.control.smartTabGroups" = "blocked";
              "browser.ai.control.smartWindow" = "blocked";
              "browser.ai.control.translations" = "blocked";
            };
          };
        };
      };
      stylix.targets.firefox = {
        colorTheme.enable = true;
        profileNames = [ "main" ];
      };
    };
}
