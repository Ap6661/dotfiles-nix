{ inputs, ... }:
{
  flake.homeModules.passwordManager =
    {
      pkgs,
      ...
    }:
    {
      programs.firefox = {
        profiles."main".extensions.packages =
          with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
            keepassxc-browser
          ];
      };

      programs.keepassxc = {
        enable = true;
        autostart = true;
        settings = { 
          FdoSecrets.Enabled = true;

          Browser = {
            Enabled = true;
          };

          GUI = {
            ApplicationTheme = "dark";
          };
        };
      };
    };
}
