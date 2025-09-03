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
    ...
  } @ inputs: let
    lib = inputs.nixpkgs.lib;
    libModule = inputs.moduleUtils.lib;

    customNamespace = "_ne";

    hostsDir = "${self}/hosts";
    hosts = lib.pipe hostsDir [
      builtins.readDir
      (lib.mapAttrsToList (p: t: let
          module = "${hostsDir}/${p}";
        in if t == "directory" then {
          inherit module;
          hostName = "${p}";
        }
        else if t == "regular" && (lib.hasSuffix ".nix" p) then {
          inherit module;
          hostName = lib.removeSuffix ".nix" p;
        }
        else null
      ))
      (builtins.filter (e: !builtins.isNull e))
    ];
    mkComputerKey = {hostName, ...}: hostName;
    mkComputer = {hostName, module}:
      lib.nixosSystem {
        specialArgs = {
          inherit inputs hostName customNamespace;
        };
        modules = [
          (self.nixosModules.default {namespace = customNamespace;})
          module
        ];
      };
  in {
    nixosConfigurations = lib.pipe hosts [
      (builtins.map (host: lib.nameValuePair (mkComputerKey host) (mkComputer host)))
      builtins.listToAttrs
    ];
    nixosModules.default = libModule.optionallyConfigureModule ({namespace ? "_ne"}:
      libModule.overlayModule {
        overlayArgs = args:
          args
          // {
            libModule = libModule.libModule {
              inherit namespace args;
            };
          };
      }
      ./modules);
  };
}
