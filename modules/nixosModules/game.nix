{ inputs, ... }:
{
  flake.nixosModules.games =
    { pkgs, ... }:
    {
      # nixpkgs.config.allowBroken = true;
      programs = { 
        gamemode.enable = true;
        steam.enable = true;
        steam.extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };
      environment.systemPackages = with pkgs; [
        lutris
        wineWow64Packages.stable
        winetricks
        # itch
      ];
    };
}
