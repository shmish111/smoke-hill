# Build a version of idris with a set of packages visible
# packages: The packages visible to idris
{ stdenv, idris2, symlinkJoin, makeWrapper, lib }:
packages:

let packagePaths = stdenv.lib.closePropagation packages;
in stdenv.lib.appendToName "with-packages" (symlinkJoin {

  inherit (idris2) name;

  paths = [ idris2 ];

  buildInputs = [ makeWrapper ];

  postBuild = ''
    wrapProgram $out/bin/idris2 \
      --set IDRIS2_PATH ${lib.concatStringsSep ":" packagePaths}
  '';

})
