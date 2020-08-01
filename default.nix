{ }:

let
  sources = import ./nix/sources.nix { };
  pkgs = import sources.nixpkgs { };
  idris2 = import ./nix/idris2.nix { inherit sources; };
  packages = import ./nix/packages.nix { inherit pkgs idris2; };
in packages // { inherit idris2; }
