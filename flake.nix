{
  description = "nenikitov's main system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    moduleUtils = {
      url = "github:nenikitov/nix-module-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    moduleUtils,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    hosts = ["nenikitov-pc-nix" "nenikitov-laptop-nix"];
    customNamespace = "_ne";
    mkComputer = hostName:
      lib.nixosSystem {
        specialArgs = {
          inherit inputs hostName customNamespace;
        };
        modules = [
          (self.nixosModules.default {namespace = customNamespace;})
          "${self}/hosts/${hostName}"
        ];
      };
  in {
    nixosConfigurations =
      lib.pipe
      hosts
      [
        (builtins.map (host: {
          name = host;
          value = mkComputer host;
        }))
        builtins.listToAttrs
      ];
    nixosModules.default = moduleUtils.lib.optionallyConfigureModule ({namespace ? "_ne"}:
      moduleUtils.lib.overlayModule {
        overlayArgs = args:
          args
          // {
            mkModule = moduleUtils.lib.mkModule namespace args.config;
          };
      }
      ./modules);
  };
}
