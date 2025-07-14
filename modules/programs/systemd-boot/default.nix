{
  config,
  lib,
  libModule,
  options,
  ...
}:
libModule.mkEnableModule {
  path = ["programs" "systemdBoot"];
  description = "systemd-boot bootloader";
  options = {
    extraEntries = options.boot.loader.systemd-boot.extraEntries;
  };
  config = {configModule, ...}: {
    boot.loader.systemd-boot = {
      enable = true;
      editor = false;
      consoleMode = "max";
      extraEntries = configModule.extraEntries;
    };
  };
}
