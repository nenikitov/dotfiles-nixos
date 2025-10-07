{
  description = "nenikitov's main system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    moduleUtils = {
      url = "github:nenikitov/nix-module-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    generationTrimmer = {
      url = "github:nenikitov/nix-generation-trimmer";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    libModule = inputs.moduleUtils.lib;
    libTreefmt = inputs.treefmt.lib;

    forAllSystems = lib.genAttrs lib.systems.flakeExposed;

    customNamespace = "_ne";

    hostsDir = "${self}/hosts";
    hosts = lib.pipe hostsDir [
      builtins.readDir
      (lib.concatMapAttrs (
        p: t:
          if t == "directory"
          then {"${p}" = p;}
          else if t == "regular" && lib.hasSuffix ".nix" p
          then {"${lib.removeSuffix ".nix" p}" = p;}
          else {}
      ))
      (builtins.mapAttrs (h: p: {
        module = "${hostsDir}/${p}";
        hostName = h;
      }))
    ];

    mkComputer = {
      module,
      hostName,
    }:
      lib.nixosSystem {
        modules = [
          # Modules
          inputs.generationTrimmer.nixosModules.default
          (self.nixosModules.default {namespace = customNamespace;})
          # Config
          module
        ];
        specialArgs = {
          inherit inputs hostName customNamespace;
        };
      };

    mkTreefmt = system: (libTreefmt.evalModule nixpkgs.legacyPackages.${system} ./treefmt.nix);
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

    formatter = forAllSystems (system: (mkTreefmt system).config.build.wrapper);
    checks = forAllSystems (system: {
      format = (mkTreefmt system).config.build.check self;
    });
  };
}
