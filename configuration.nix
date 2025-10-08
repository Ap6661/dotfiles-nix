{ pkgs, config, inputs, ... }:
let
  c = {
    base00 = "#000000";
    base01 = "#1a0c14";
    base02 = "#321c29";
    base03 = "#533144";
    base04 = "#7c4d68";
    base05 = "#af6e92";
    base06 = "#cda3b9";
    base07 = "#ecdfe6";
    base08 = "#e07d8b";
    base09 = "#e0957e";
    base0A = "#e0c87e";
    base0B = "#84e07e";
    base0C = "#7ee0d8";
    base0D = "#7e8ee0";
    base0E = "#e07ece";
    base0F = "#b26e44";
  };
in
{
  imports =
    [
      ./user/x/i3/i3.nix
      ./user/x/rofi/rofi.nix
      ./user/general/cli/btop/btop.nix
      ./user/general/cli/zsh/zsh.nix
      ./user/general/gui/messaging/messaging.nix
      ./user/general/gui/wezterm/wezterm.nix
      ./special.nix
    ];
  stylix = {
    enable = true;
    base16Scheme = pkgs.lib.mkIf (config.specialisation != { })
      {
        base00 = c.base00;
        base01 = c.base01;
        base02 = c.base02;
        base03 = c.base03;
        base04 = c.base04;
        base05 = c.base05;
        base06 = c.base06;
        base07 = c.base07;
        base08 = c.base08;
        base09 = c.base09;
        base0A = c.base0A;
        base0B = c.base0B;
        base0C = c.base0C;
        base0D = c.base0D;
        base0E = c.base0E;
        base0F = c.base0F;
      };
    image = pkgs.lib.mkIf (config.specialisation != { }) ./user/theme/background;
    # image = ./user/theme/background;
    # image = pkgs.runCommand "image.png" {} '' 
    #   ${pkgs.imagemagick}/bin/magick convert ${./user/theme/bg.jpg} -fill "${config.stylix.base16Scheme.base00}" -colorize 60 $out
    # '';
  };

  ## USE FLAKES!
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ####################
  #  CUSTOM MODULES  #
  ####################

  i3.enable = true;
  rofi.enable = true;

  programs.dconf.enable = true;

  wezterm.enable = true;

  zsh.enable = true;
  btop.enable = true;

  messaging.enable = true;

  ####################

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  i18n.inputMethod = {
    enable = true; 
    type = "fcitx5";
    fcitx5.addons = with pkgs; [ 
      fcitx5-mozc-ut
    ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  boot = {
    # Bootloader.
    loader = {
      systemd-boot.enable = false;
      limine = {
        enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
    binfmt.emulatedSystems = [ "armv7l-linux" "x86_64-windows" ];
    supportedFilesystems = [ "ntfs" ];
  };

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
      sddm = {
        enable = true;
        theme = "where_is_my_sddm_theme_qt5";
      };
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

      distrobox
      qemu

      (ffmpeg.override {
       withXcb = true;
       withCaca = true;
       })

      # SDDM theme
      (where-is-my-sddm-theme.override {
        themeConfig.General = {
          backgroundFill = "${config.stylix.base16Scheme.base00}";
          passwordCursorColor = "${config.stylix.base16Scheme.base01}";
          passwordTextColor = "${config.stylix.base16Scheme.base0E}";
        };
        variants = [ "qt5" ];
      })


      firefox
      file
      git
      gh
      gcc
      unzip
      wget
      (writers.writeBashBin "myBashScript" ''
        echo Hello
      '')

      (writers.writeBashBin "revert-specialisation" ''
        $(nix eval --read-only --raw ${inputs.self}\#nixosConfigurations.$(hostname).config.system.build.toplevel.outPath)/bin/switch-to-configuration test
      '')

      (writers.writeBashBin "hmex" ''
        mkdir output
        echo '${builtins.toJSON (map (x:
              config.home-manager.users.apnda.home.file."${x}".target)
            (builtins.attrNames config.home-manager.users.apnda.home.file))}' |
        nix run nixpkgs#jq -- ".[]" |
        xargs -I {} sh -c "(find ~/{}/* || echo ~/{})" 2> /dev/null |
        xargs -I {} sh -c "mkdir -p output\$(dirname {}); cat {} > output{}" 2> /dev/null
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
      "dialout"
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

}
