{
  config,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = ["hardware" "bluetooth"];
  options = {
    enable = lib.mkEnableOption "support for bluetooth (via bluez)";
  };
  config = configLocal:
    lib.mkIf configLocal.enable {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General.Experimental = true;
        };
      };
    };
}
