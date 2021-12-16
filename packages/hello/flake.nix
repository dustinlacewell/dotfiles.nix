{
  description = "A flake for building Hello World";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in {
      defaultPackage.x86_64-linux = pkgs.callPackage ./. { };
    };
}

