{ config, pkgs, customNamespace, lib, hostName, ... }@inputs:
lib.mkMerge [
  # Flake boilerplate
  {
    nix = {
      # Necessary features for flakes
      settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Make nix3 and legacy commands consistent with flakes
      registry =
        lib.pipe inputs
        [
          (lib.filterAttrs (k: v: lib.isType "flake" v))
          (lib.mapAttrs (k: flake: { inherit flake; }))
        ];
      nixPath = lib.mapAttrsToList (k: v: "${k}=${v.to.path}") config.nix.registry;
    };
  }

  # Misc
  {
    networking.hostName = hostName;
    documentation.nixos.includeAllModules = true;
  }
]
