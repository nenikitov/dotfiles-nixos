{libModule, ...}:
libModule.mkEnableModule {
  path = ["settings" "garbageCollection"];
  description = "automatic garbage collection";
  config = {
    nix = {
      settings.auto-optimise-store = true;
      optimise = {
        automatic = true;
        dates = "daily";
      };

      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 7d";
      };
    };
  };
}
