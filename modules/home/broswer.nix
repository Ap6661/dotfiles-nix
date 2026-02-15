{ inputs, ... }:
{

  flake.homeModules.browser = 
  {
    pkgs,
    ... 
  }: 
  {
    programs.firefox = {
      enable = true;
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




