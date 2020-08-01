{ package-sources ? import ./package-sources.nix, pkgs, idris2 }:

let
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

in rec {
  inherit idris2;
  Idris-Bifunctors =
    mkIdrisPackage "bifunctors" package-sources.Idris-Bifunctors [ ];
  idris-lens =
    mkIdrisPackage "lens" package-sources.idris-lens [ Idris-Bifunctors ];
  wl-pprint = mkIdrisPackage "wl-pprint" package-sources.wl-pprint [ ];
  optparse = mkIdrisPackage "optparse" package-sources.optparse-idris [ wl-pprint idris-lens Idris-Bifunctors ];
}
