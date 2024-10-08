{
  description = "André's NixOS configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixpkgs-master,
    ...
  }:
  let
    system-type = {
      amd64-linux = "x86_64-linux";
    };

    sources = {

      nixpkgs-stable = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      nixpkgs-unstable = system: import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      nixpkgs-master = system: import nixpkgs-master {
        inherit system;
        config.allowUnfree = false;
      };

    };

    useSource = system: source: source system;
    useSources = system: sources:
      builtins.mapAttrs (name: value: useSource system value) sources;

    createHost = { system ? system-type.amd64-linux, main-source ? sources.nixpkgs-stable, extra-sources ? [], modules }:
      nixpkgs.lib.nixosSystem {
        inherit system modules;

        specialArgs = {
          pkgs = useSource system main-source;
          extra-pkgs = useSources system extra-sources;
          inherit inputs;
        };
      };

  in {
    nixosConfigurations = {

      # my main desktop
      "Tesla" = createHost {
        extra-sources = {
          inherit (sources)
            nixpkgs-unstable
            nixpkgs-master
          ;
        };
        # extra-sources = repos;
        modules = [
          ./configuration.nix
        ];
      };

    };
  };

}
