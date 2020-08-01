let
  sources = import ./nix/sources.nix { };
  pkgs = import sources.nixpkgs { };
  packages = import ./default.nix {};
in
with pkgs; mkShell {
  buildInputs = [
    gmp chez packages.idris2 niv
  ];
}
