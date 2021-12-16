{ pkgs, ... }:

{
  recImport = pkgs.callPackage ./recImport {};
}