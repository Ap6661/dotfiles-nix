{ inputs, ... }:
{
  systems = [
    "x86_64-linux"
  ];
  perSystem =
    { system, ... }:
    let
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      _module.args = { inherit pkgs; };
      formatter = pkgs.nixfmt-tree;
    };
}
