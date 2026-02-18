{ inputs, ... }:
{
  flake.nixosModules.core = 
  { pkgs, config, ... }:
  let
    inherit (config.custom.constants) host;
  in
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


    networking = {
      hostName = host; # Define your hostname.
        networkmanager.enable = true;
    };

    time.timeZone = "America/Chicago";
    i18n = { 
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };

    };

    xdg.sounds.enable = false;

    services.fwupd.enable = true;

    system.stateVersion = "23.11"; # Don't Change This
  };
}
