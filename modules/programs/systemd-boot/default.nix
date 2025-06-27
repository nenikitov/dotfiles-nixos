{
  config,
  lib,
  mkModule,
  options,
  ...
}:
mkModule config {
  path = ["programs" "systemdBoot"];
  description = "systemd-boot bootloader";
  options = {
    extraEntries = options.boot.loader.systemd-boot.extraEntries;
  };
  config = configLocal: {
    boot.loader.systemd-boot = {
      enable = true;
      editor = false;
      consoleMode = "max";
      extraEntries = configLocal.extraEntries;
    };
  };
}
