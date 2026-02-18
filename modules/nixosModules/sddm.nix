{ ... }:
{
  flake.nixosModules.sddm =
    {
      config,
      pkgs,
      ...
    }:
    {

      services = {
        displayManager.sddm = {
          enable = true;
          theme = "where_is_my_sddm_theme";
        };
      };
      environment.systemPackages = [
        (pkgs.where-is-my-sddm-theme.override {
          themeConfig.General = {
            backgroundFill = "${config.stylix.base16Scheme.base00}";
            passwordCursorColor = "${config.stylix.base16Scheme.base01}";
            passwordTextColor = "${config.stylix.base16Scheme.base0E}";
          };
          variants = [ "qt6" ];
        })
      ];
    };
}
