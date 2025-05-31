{ pkgs, lib, config, ... }: {
  specialisation = lib.lists.foldr (a: b: a // b) { } (lib.lists.forEach
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
    ]
    (c:
      {
        ${c.name}.configuration = {
          config.stylix = {
            base16Scheme = {
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
            image = pkgs.runCommand "image.png" { } "${pkgs.imagemagick}/bin/magick -size 1x1 xc:${c.base03} $out\n";
          };
        };
      }));
}
