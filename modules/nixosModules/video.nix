{ ... }:
{

  flake.nixosModules.core =
    {
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        (mpv.override {
          # sixelSupport = true;
          scripts = with pkgs.mpvScripts; [
            uosc
            sponsorblock
          ];
        })
        yt-dlp
      ];
    };
}
