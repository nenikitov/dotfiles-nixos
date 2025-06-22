{
  config,
  customNamespace,
  hostName,
  lib,
  mkModule,
  pkgs,
  ...
} @ inputs:
mkModule config {
  path = ["profiles" "minimal"];
  options = {
    enable = lib.mkEnableOption "a bare-bones, minimal profile";
  };
  config = configLocal:
    lib.mkIf configLocal.enable
    {
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
        nixPath = lib.mapAttrsToList (k: v: "${k}=${v.to.path}") config.nix.registry;
      };

      "${customNamespace}" = {
        settings = {
          garbageCollection = true;
          locale.enable = true;
          numlock.enable = true;
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
        git
        tree
        vim
      ];
    };
}
