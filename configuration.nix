{ pkgs, ... }:

{
  imports =
    [
      ./user/x/i3/i3.nix
      ./user/x/rofi/rofi.nix
      ./user/general/cli/btop/btop.nix
      ./user/general/cli/zsh/zsh.nix
      ./user/general/gui/messaging/messaging.nix
      ./user/general/gui/wezterm/wezterm.nix
      ./user/theme/gtk.nix
    ];


  ## USE FLAKES!
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ####################
  #  CUSTOM MODULES  #
  ####################

  i3.enable = true;
  rofi.enable = true;


  programs.dconf.enable = true;
  #  nvim.enable = true;

  wezterm.enable = true;

  zsh.enable = true;
  btop.enable = true;
  gtk-theme.enable = true;

  messaging.enable = true;

  ####################


  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
# Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Configure keymap in X11

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    displayManager = {
      sddm.enable = true;
      sddm.theme = "${import ./user/theme/sddm.nix { inherit pkgs; }}";
    };
  };

  services = {
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 80;
      };
    };
  };

  # Get rid of that god awful bell. This is a weird way but it works
  xdg.sounds.enable = false;

  environment = {
    systemPackages = with pkgs; [
      firefox
        git
        gh
        gcc
        unzip
        wget
        (writers.writeBashBin "myBashScript" ''
          echo Hello
        '')
        (stdenv.mkDerivation {
          name = "test package";
          src = ./.;
          installPhase = ''
            mkdir -p $out/share/sounds 
            echo This is a test > $out/share/sounds/test
          '';
        })
    ];
    pathsToLink = [ "/share/sounds" ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.apnda = {
    isNormalUser = true;
    description = "APnda";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    initialPassword = "ChangeMe";
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  services.fwupd.enable = true;
  virtualisation.docker.enable = true;


}
