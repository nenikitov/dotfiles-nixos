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
      (lib.concatMapAttrs (p: t:
        if t == "directory" then { "${p}" = p; }
        else if t == "regular" && lib.hasSuffix ".nix" p then { "${lib.removeSuffix ".nix" p}" = p; }
        else {}
      ))
      (builtins.mapAttrs (h: p: {
        module = "${hostsDir}/${p}";
        hostName = h;
      }))
    ];

    mkComputer = {module, hostName}:
      lib.nixosSystem {
        modules = [
          (self.nixosModules.default {namespace = customNamespace;})
          module
        ];
        specialArgs = {
          inherit inputs hostName customNamespace;
        };
      };
  in {
    nixosConfigurations = builtins.mapAttrs (_: mkComputer) hosts;
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
