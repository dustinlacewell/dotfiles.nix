{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    secrets.url = "path:/home/ldlework/dotfiles-secrets";

    myhello = {
      url = "path:/home/ldlework/dotfiles/packages/hello";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixt = { url = "github:nix-community/nixt/typescript-rewrite"; };
  };

  outputs = inputs@{ nixpkgs, home-manager, secrets, ... }:
    let
      recImport =
        nixpkgs.legacyPackages.x86_64-linux.callPackage ./utils/recImport.nix
        { };
      localLib = nixpkgs.callPackage ./utils { };
      localModules = recImport ./modules;
    in {
      lib = localLib;
      nixosModules = localModules;
      nixosConfigurations = {
        logos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux"; # the system architecture
          modules = localModules ++ [
            home-manager.nixosModules.home-manager
            ./hosts/x86_64-linux/logos
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ldlework =
                import ./hosts/x86_64-linux/logos/ldlework.nix;
            }
          ];
          specialArgs = { inherit inputs secrets; };
        };
      };
    };
}
