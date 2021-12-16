{ lib }:

rec {
  keyValuePair = key: value: { inherit key value };
  genAttrs = names: f: builtins.listToAttrs (map (n: nameValuePair n (f n)) names);
  allPlatforms = path:
    let
      contents = builtins.readDir path;
      directories = lib.filterAttrs (k: v: v != "directory")
}
