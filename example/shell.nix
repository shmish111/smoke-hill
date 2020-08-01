let
  sources = import ./nix/sources.nix { };
  pkgs = import sources.nixpkgs { };
  packages = import sources.smoke-hill { };
  # Create an idris2 executable that has access to the wl-pprint and lens libraries
  exampleIdrisWithPackages =
    packages.withPackages [ packages.wl-pprint packages.lens ];
in with pkgs; mkShell { buildInputs = [ gmp chez exampleIdrisWithPackages ]; }
