{ inputs, ... }:
{

  flake.nixosModules.virt =
    { pkgs, config, ... }:
    let
      inherit (config.custom.constants) user;
    in
    {
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
      };

      environment.systemPackages = with pkgs; [
        distrobox
        looking-glass-client
        # qemu_full
      ];

      programs.virt-manager.enable = true;
      users.groups.libvirtd.members = [ user ];
      virtualisation = {
        libvirtd.enable = true;
        spiceUSBRedirection.enable = true;
      };

      boot = {
        extraModulePackages = [ config.boot.kernelPackages.kvmfr ];
        kernelModules = [ "kvmfr" ];
        extraModprobeConfig = ''
          options kvmfr static_size_mb=32
        '';
      };
      services.udev.extraRules = ''
        SUBSYSTEM=="kvmfr", OWNER="${user}", GROUP="kvm", MODE="0660"
      '';
      virtualisation.libvirtd.qemu.verbatimConfig = ''
        cgroup_device_acl = [
        "/dev/null", "/dev/full", "/dev/zero",
        "/dev/random", "/dev/urandom",
        "/dev/ptmx", "/dev/kvm",
        "/dev/kvmfr0"
        ]
      '';
    };
}
