{ inputs, ... }:
{
  flake.nixosModules.core = 
  { 
    pkgs,
    config,
    ... 
  }: let
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
    imports = [
      inputs.stylix.nixosModules.stylix
    ];

    stylix = {
      enable = true;
      base16Scheme = # pkgs.lib.mkIf (config.specialisation != { })
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
      image = ./background;
# image = ./user/theme/background;
# image = pkgs.runCommand "image.png" {} '' 
#   ${pkgs.imagemagick}/bin/magick convert ${./user/theme/bg.jpg} -fill "${config.stylix.base16Scheme.base00}" -colorize 60 $out
# '';
    };
  };


}
