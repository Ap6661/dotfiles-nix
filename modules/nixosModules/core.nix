{ inputs, ... }:
{
  flake.nixosModules.core = 
  { ... }:
  {
    boot = {
      loader = {
        systemd-boot.enable = false;
        limine = {
          enable = true;
          enableEditor = true;
        };
        efi.canTouchEfiVariables = true;
      };
      # binfmt.emulatedSystems = [ "armv7l-linux" "x86_64-windows" ];
      # supportedFilesystems = [ "ntfs" ];
    };

    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    system.stateVersion = "23.11"; # Don't Change This
  };
}
