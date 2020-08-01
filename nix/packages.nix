{ package-sources ? import ./package-sources.nix, sources ? import ./sources.nix
, pkgs ? import sources.nixpkgs { } }:

let
  idris2 = import ./idris2.nix { inherit sources; };
  mkIdrisPackage = name: src: deps:
    with pkgs;
    let
      installDep = dep: ''
        cp -r ${dep}/ ./${dep.name}/
        export IDRIS2_PATH=$IDRIS2_PATH:./${dep.name}
      '';
      installDeps = pkgs.lib.concatStringsSep "\n" (map installDep deps);
    in stdenv.mkDerivation rec {
      inherit name src;
      buildPhase = ''
        ${installDeps}
        ${idris2}/bin/idris2 --build ${name}.ipkg
      '';
      installPhase = ''
        mkdir $out
        cp -R ./build/ttc/* $out/
      '';
    };

  withPackages = pkgs.callPackage ./with-packages.nix { inherit idris2; };

in rec {
  inherit idris2 withPackages;
  bifunctors = mkIdrisPackage "bifunctors" package-sources.Idris-Bifunctors [ ];
  lens = mkIdrisPackage "lens" package-sources.idris-lens [ bifunctors ];
  wl-pprint = mkIdrisPackage "wl-pprint" package-sources.wl-pprint [ ];
  optparse = mkIdrisPackage "optparse" package-sources.optparse-idris [
    wl-pprint
    lens
    bifunctors
  ];
}
