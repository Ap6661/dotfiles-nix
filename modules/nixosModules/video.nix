{ ... }: {
  
  flake.nixosModules.core = 
  {
    pkgs,
    ...
  }:
  {
    environment.systemPackages = [
      (pkgs.mpv-unwrapped.override {
       sixelSupport = true;
       }) 
    ];
  };
}
