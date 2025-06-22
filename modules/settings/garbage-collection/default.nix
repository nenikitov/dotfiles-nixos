{
  config,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = ["settings" "garbageCollection"];
  options = {
    enable = lib.mkEnableOption "automatic garbage collection";
  };
  config = configLocal:
    lib.mkIf configLocal.enable {
      nix = {
        settings.auto-optimise-store = true;
        optimise = {
          automatic = true;
          dates = "weekly";
        };

        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };
      };
    };
}
