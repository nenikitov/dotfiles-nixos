{
  config,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = ["hardware" "bluetooth"];
  description = "support for bluetooth (via bluez)";
  config = configLocal: {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General.Experimental = true;
      };
    };
  };
}
