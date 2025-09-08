{
  hostName,
  lib,
  libModule,
  pkgs,
  ...
} @ inputs:
libModule.mkEnableModule {
  path = ["profiles" "minimal"];
  description = "a bare-bones, minimal profile";
  config = {
    namespace,
    configGlobal,
    ...
  }: {
    nix = {
      # Necessary features to enable flakes
      settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Make nix3 and legacy commands consistent with flakes
      registry =
        lib.pipe inputs
        [
          (lib.filterAttrs (k: v: lib.isType "flake" v))
          (lib.mapAttrs (k: flake: {inherit flake;}))
        ];
      nixPath = lib.mapAttrsToList (k: v: "${k}=${v.to.path}") configGlobal.nix.registry;
    };

    "${namespace}" = {
      settings = {
        garbageCollection.enable = true;
        locale.enable = true;
        numlock.enable = true;
      };
      programs = {
        ly.enable = true;
        systemdBoot.enable = true;
      };
      hardware = {
        network.enable = true;
        nuphy.enable = true;
      };
      users = {
        nenikitov.enable = true;
      };
    };

    networking = {inherit hostName;};

    boot.supportedFilesystems.ntfs = true;

    documentation.nixos.includeAllModules = true;

    nixpkgs.config.allowUnfree = true;
    environment.systemPackages = with pkgs; [
      file
      git
      tree
      vim
    ];
  };
}
