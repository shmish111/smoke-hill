{ sources ? import ./nix/sources.nix
, idris2 ? import ./nix/idris2.nix { inherit sources; } }:

let packages = import ./nix/packages.nix { inherit idris2; };
in packages
