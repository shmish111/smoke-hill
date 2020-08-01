{ sources }:

let
  pkgs = import sources.nixpkgs { };
  package-sources = import ./package-sources.nix { };
  idris2 = with pkgs;
    stdenv.mkDerivation {
      name = "idris2";
      src = package-sources.Idris2;
      strictDeps = true;
      nativeBuildInputs = [ makeWrapper clang chez ];
      buildInputs = [ chez ];

      prePatch = ''
        patchShebangs --build tests
      '';

      makeFlags = [ "PREFIX=$(out)" ]
        ++ stdenv.lib.optional stdenv.isDarwin "OS=";

      # The name of the main executable of pkgs.chez is `scheme`
      buildFlags = [ "bootstrap-build" "SCHEME=scheme" ];

      checkTarget = "bootstrap-test";

      # idris2 needs to find scheme at runtime to compile
      postInstall = ''
        wrapProgram "$out/bin/idris2" --set CHEZ "${chez}/bin/scheme"
      '';

      meta = {
        description =
          "A purely functional programming language with first class types";
        homepage = "https://github.com/idris-lang/Idris2";
        license = stdenv.lib.licenses.bsd3;
        maintainers = with stdenv.lib.maintainers; [ wchresta ];
        inherit (chez.meta) platforms;
      };
    };
in idris2
