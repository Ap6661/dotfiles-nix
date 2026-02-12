{ inputs, self, ... }@topLevel:
{
  flake.nixosModules.host-nixos = { pkgs, ... }: {

    imports = with topLevel.config.flake.nixosModules; [
      games
      i3
      sddm

      inputs.nixos-hardware.nixosModules.framework-13th-gen-intel
    ];

    powerManagement.enable = true;

    boot.kernelParams = [ "resume=/swapfile" "resume_offset=423411712" ];
    boot.resumeDevice = "/dev/disk/by-uuid/79bcf5e9-d6b7-4b39-b509-41336f8fbd55";
    security.protectKernelImage = false;

    services.logind.settings.Login = {
      HandlePowerKey = "hibernate";
      HandleLidSwitch = "suspend";
    };

    services.udev.extraRules = '' SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="5", RUN+="${pkgs.systemd}/bin/systemctl hibernate" '';

    services.kanata = {
      enable = true;
      keyboards = {
        internalKeyboard = {
          devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
          config = ''
            (defsrc
             grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
             tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
             caps a    s    d    f    g    h    j    k    l    ;    '    ret
             lsft z    x    c    v    b    n    m    ,    .    /    rsft
             lctl lmet lalt           spc            ralt rctl
            )

            (defalias
             osh (one-shot 500 lsft)
             ors (one-shot 500 rsft)
             ect (tap-hold 100 100 esc lctl)

             al (tap-hold 200 200 (one-shot 200 ralt) (layer-while-held arrow))

             < S-,
             > S-.
             ~ S-grv

             sqn (macro @> @~ @<)
             abr (macro @< @> left)

             gam (layer-switch gaming)
             bas (layer-switch base)

            )

            (deflayer base
             grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
             tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
             @ect a    s    d    f    g    h    j    k    l    ;    '    ret
             @osh z    x    c    v    b    n    m    ,    .    /    @ors
             lctl lmet lalt           spc            @al  rctl
            )

            (deflayer arrow
             grv S-1  S-2  S-3  S-4  S-5  S-6  S-7  S-8   S-9  S-0    -    =    bspc
             tab  1    2    3    4    5    6    7    8     9    0    [    ]    \
             @ect a    s    d @sqn    g left down   up right    ;    '    ret
             @osh @gam @abr    c    v    b    n    m    ,     .    /    rsft
             lctl lmet lalt           spc            ralt rctl
            )

            (deflayer gaming
             grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
             tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
             lctl a    s    d    f    g    h    j    k    l    ;    '    ret
             lsft z    x    c    v    b    n    m    ,    .    /    rsft
             lctl esc lalt           spc            @bas  rctl
            )
            '';
        };
      };
    };

    services.xserver.displayManager.sessionCommands = ''
      ${pkgs.xinput}/bin/xinput set-prop PIXA3854:00\ 093A:0274\ Touchpad libinput\ Natural\ Scrolling\
      Enabled 1
      '';

    # inputs.home-manager.users.apnda.programs.firefox.profiles."main".settings."layout.css.devPixelsPerPx" = 1.5;
    
  };
}
