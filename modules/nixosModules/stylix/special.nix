{ inputs, lib, ... }: 
{

  flake.nixosModules.core = { pkgs, ... }: {
    # specialisation = {
      # test.configuration = {
      #   services.displayManager.defaultSession = "niri";
      #   programs.niri.enable = true;
      # };
    # };
    specialisation = lib.lists.foldr (a: b: a // b) {} (lib.lists.forEach
    [
      {
        name = "gruvbox";
        base00 = "#282828";
        base01 = "#3c3836";
        base02 = "#504945";
        base03 = "#665c54";
        base04 = "#bdae93";
        base05 = "#d5c4a1";
        base06 = "#ebdbb2";
        base07 = "#fbf1c7";
        base08 = "#fb4934";
        base09 = "#fe8019";
        base0A = "#fabd2f";
        base0B = "#b8bb26";
        base0C = "#8ec07c";
        base0D = "#83a598";
        base0E = "#d3869b";
        base0F = "#d65d0e";
      }
      {
        name = "mocha";
        base00 = "#3B3228";
        base01 = "#534636";
        base02 = "#645240";
        base03 = "#7e705a";
        base04 = "#b8afad";
        base05 = "#d0c8c6";
        base06 = "#e9e1dd";
        base07 = "#f5eeeb";
        base08 = "#cb6077";
        base09 = "#d28b71";
        base0A = "#f4bc87";
        base0B = "#beb55b";
        base0C = "#7bbda4";
        base0D = "#8ab3b5";
        base0E = "#a89bb9";
        base0F = "#bb9584";
      }
      {
        name = "Rosepine";
        base00 = "#232136";
        base01 = "#2a273f";
        base02 = "#393552";
        base03 = "#6e6a86";
        base04 = "#908caa";
        base05 = "#e0def4";
        base06 = "#e0def4";
        base07 = "#56526e";
        base08 = "#eb6f92";
        base09 = "#f6c177";
        base0A = "#ea9a97";
        base0B = "#3e8fb0";
        base0C = "#9ccfd8";
        base0D = "#c4a7e7";
        base0E = "#f6c177";
        base0F = "#56526e";
      }
      {
        name = "Club";
        base00 = "#17312f"; ## #17312f  ----
        base01 = "#225649"; ## #225649  ---
        base02 = "#286856"; ## #286856  --
        base03 = "#2d7a62"; ## #2d7a62  -
        base04 = "#389f7b"; ## #389f7b  +
        base05 = "#42c394"; ## #42c394  ++
        base06 = "#53c89e"; ## #53c89e  +++
        base07 = "#63cda7"; ## #63cda7  ++++
        base08 = "#db3838"; ## #db3838        red
        base09 = "#de8b26"; ## #de8b26        orange
        base0A = "#dcdf25"; ## #dcdf25        yellow
        base0B = "#44de26"; ## #44de26        green
        base0C = "#26adde"; ## #26adde        aqua
        base0D = "#264bde"; ## #264bde        blue
        base0E = "#d226de"; ## #d226de        purple
        base0F = "#a44b03"; ## #a44b03        brown
      }
    ]
    (c: {
      ${c.name}.configuration = {
        config.stylix = {
        base16Scheme = lib.lists.foldr (a: b: a // b) {} (lib.lists.forEach 
        [ 
        "base00"
        "base01"
        "base02"
        "base03"
        "base04"
        "base05"
        "base06"
        "base07"
        "base08"
        "base09"
        "base0A"
        "base0B"
        "base0C"
        "base0D"
        "base0E"
        "base0F"
        ]
        (b: {
          ${b} = c.${b};
        }));
        image = lib.mkForce (pkgs.runCommand "image.png" { } "${pkgs.imagemagick}/bin/magick -size 1x1 xc:${c.base03} $out\n");
        };

      };
      }));
  };
}




