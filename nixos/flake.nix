{
  description = "André's NixOS configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    nixpkgs-unstable,
    ...
  }: {
    nixosConfigurations = {
      Tesla = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
  
        specialArgs = {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
  	  pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        };
  
        modules = [
          ./configuration.nix
        ];
      };
    };

  };

}
