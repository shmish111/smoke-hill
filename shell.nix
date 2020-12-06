let
  sources = import ./nix/sources.nix { };
  pkgs = import sources.nixpkgs { };
  packages = import ./default.nix { };
  exampleIdrisWithPackages =
    packages.withPackages [ packages.wl-pprint packages.lens packages.bifunctors packages.optparse packages.idris2api ];
in with pkgs;
mkShell { buildInputs = [ gmp chez niv exampleIdrisWithPackages nixfmt ]; }
