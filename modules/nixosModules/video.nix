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
        (ani-cli.overrideAttrs (old: {
          version = "5.1";
          src = fetchFromGitHub {
            owner = "pystardust";
            repo = "ani-cli";
            tag = "v5.1";
            hash = "sha256-lPQA3iO3F/9NS2IziQccsJ3aai6WMQy6YObdB3mDCZA=";
          };

        }))
      ];
    };
}
