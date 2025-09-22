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

        generationTrimmer = {
          enable = true;
          keepAtLeast = 10;
          keepAtMost = 50;
          olderThan = "1 month";
        };
      };
    };
  };
}
