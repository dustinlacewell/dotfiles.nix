{ stdenv }:

stdenv.mkDerivation {
  name = "myhello";
  src = ./.;
  buildPhase = "gcc -o hello ./hello.c";
  installPhase = "mkdir -p $out/bin; install -t $out/bin hello";
}
