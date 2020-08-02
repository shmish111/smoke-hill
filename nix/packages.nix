{ package-sources ? import ./package-sources.nix, sources ? import ./sources.nix
, pkgs ? import sources.nixpkgs { }
, idris2 ? import ./idris2.nix { inherit sources; } }:

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

  mkIdrisExecutable = name: src: deps:
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
        mkdir -p $out/bin
        cp -R ./build/exec/* $out/bin/
      '';
    };

  idris2Api = with pkgs;
    stdenv.mkDerivation rec {
      name = "idris2api";
      src = package-sources.Idris2;
      buildPhase = ''
        make src/IdrisPaths.idr
        ${idris2}/bin/idris2 --build ${name}.ipkg
      '';
      installPhase = ''
        mkdir $out
        cp -R ./build/ttc/* $out/
      '';
    };

  withPackages = pkgs.callPackage ./with-packages.nix { inherit idris2; };

in rec {
  inherit idris2 withPackages idris2Api mkIdrisPackage mkIdrisExecutable;
  bifunctors = mkIdrisPackage "bifunctors" package-sources.Idris-Bifunctors [ ];
  lens = mkIdrisPackage "lens" package-sources.idris-lens [ bifunctors ];
  wl-pprint = mkIdrisPackage "wl-pprint" package-sources.wl-pprint [ ];
  optparse = mkIdrisPackage "optparse" package-sources.optparse-idris [
    wl-pprint
    lens
    bifunctors
  ];
}
