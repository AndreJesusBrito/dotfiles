{
  description = "André's NixOS configs";

  inputs = {
    # stable nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, ... }@inputs: {

    nixosConfigurations.Tesla = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };

  };
}
