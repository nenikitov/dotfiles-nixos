{
  lib,
  mkModule,
  ...
}:
mkModule {
  path = ["settings" "garbageCollection"];
  description = "automatic garbage collection";
  config = {
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
