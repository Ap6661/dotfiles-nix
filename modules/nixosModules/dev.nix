{ ... }: 
{
  flake.nixosModules.core = 
  {
    pkgs,
    ...
  }:
  { 
    environment.systemPackages = with pkgs; [
      git 
      gh
      gcc
      unzip
      wget
      file
    ];

  };
}
