{
  pkgs,
  config,
  nixos-hardware,
  ...
}:
{
  imports = [
  ];

  hardware.graphics.enable = true;

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  programs = {
    steam.gamescopeSession.enable = true;
    noisetorch.enable = true;
  };

  services = {
    # Load nvidia driver for Xorg and Wayland
    xserver.videoDrivers = [ "nvidia" ];
    xserver.displayManager.setupCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-0 --auto --left-of DP-3
    '';
    monado.enable = true;
  };

  environment.systemPackages = with pkgs; [ wlx-overlay-s ];

  # boot.kernelParams = [ "resume=/swapfile" "resume_offset=423411712" ];
  # boot.resumeDevice = "/dev/disk/by-uuid/79bcf5e9-d6b7-4b39-b509-41336f8fbd55";
}
