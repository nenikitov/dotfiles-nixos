{
  libModule,
  pkgs,
  ...
}:
libModule.mkEnableModule {
  path = ["settings" "garbageCollection"];
  description = "automatic garbage collection";
  config = {configGlobal, ...}: {
    nix = {
      settings.auto-optimise-store = true;
      optimise = {
        automatic = true;
        dates = "daily";
      };

      gc = {
        automatic = true;
        dates = "daily";
      };
    };

    systemd.services = {
      # Make built-in service depend on the generation selector
      nix-gc.wants = ["nix-gc-gen.service"];
      # Generation selector for garbage collection
      nix-gc-gen = {
        description = "Generation selector for garbage collection";
        serviceConfig.Type = "oneshot";
        script =
          # sh
          ''
            exec "${pkgs.nix-generation-trimmer}/bin/nix-generation-trimmer" \
              system                                                         \
              --older-than 7d                                                \
              --keep-at-least 10                                             \
              --keep-at-most 50
          '';
        path = [configGlobal.nix.package.out];
      };
    };
  };
}
