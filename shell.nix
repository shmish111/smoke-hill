let
  sources = import ./nix/sources.nix { };
  pkgs = import sources.nixpkgs { };
in with pkgs;
let
  packages = import ./default.nix { };
  idris2 = packages.idris2;
  withPackages = callPackage ./nix/with-packages.nix { inherit idris2; };
  exampleIdrisWithPackages =
    withPackages [ packages.wl-pprint packages.lens ];
in mkShell { buildInputs = [ gmp chez niv exampleIdrisWithPackages ]; }
