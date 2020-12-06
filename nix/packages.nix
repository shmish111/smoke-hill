{ package-sources ? import ./package-sources.nix, sources ? import ./sources.nix
, pkgs ? import sources.nixpkgs { }
, idris2 ? import ./idris2.nix { inherit sources; } }:

let
  mkIdrisPackage = packages: name:
    with pkgs;
    let
      src = builtins.getAttr name package-sources;
      deps = map (dep: builtins.getAttr dep packages) src.dependencies;
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

  idris2api = with pkgs;
    stdenv.mkDerivation rec {
      name = "idris2api";
      src = package-sources.Idris2;
      patches = [ ./make.patch ];

      buildFlags = [ "build-api" "IDRIS2_BOOT=${idris2}/bin/idris2" ];

      # preInstall = ''
      #   mkdir -p $out
      #   echo 'print-libdir : ; $(info ''${NAME}-''${IDRIS2_VERSION}) @true' > print.mak
      #   cat print.mak
      #   IDRIS_LIB_DIR=$(make -f print.mak -f Makefile print-libdir)
      #   mkdir -p $out/$IDRIS_LIB_DIR/idris2
      #   cp -R ./build/ttc/* $out/$IDRIS_LIB_DIR/idris2/
      # '';
      installPhase = ''
        mkdir $out
        cp -R ./build/ttc/* $out/
      '';
    };

  withPackages = pkgs.callPackage ./with-packages.nix { inherit idris2; };

  ps = rec {
    inherit idris2 withPackages idris2api mkIdrisPackage mkIdrisExecutable;
    bifunctors = mkIdrisPackage ps "bifunctors";
    lens = mkIdrisPackage ps "lens";
    wl-pprint = mkIdrisPackage ps "wl-pprint";
    optparse = mkIdrisPackage ps "optparse";
  };
in ps
