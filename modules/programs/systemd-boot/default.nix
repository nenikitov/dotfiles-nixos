{
  config,
  lib,
  mkModule,
  options,
  ...
}:
mkModule config {
  path = ["programs" "systemdBoot"];
  options = {
    enable = lib.mkEnableOption "systemd-boot bootloader";
    extraEntries = options.boot.loader.systemd-boot.extraEntries;
  };
  config = configLocal:
    lib.mkIf configLocal.enable {
      boot.loader.systemd-boot = {
        enable = true;
        editor = false;
        consoleMode = "max";
        extraEntries = configLocal.extraEntries;
      };
    };
}
