{libModule, ...}:
libModule.mkEnableModule {
  path = ["hardware" "bluetooth"];
  description = "support for bluetooth (via bluez)";
  config = {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General.Experimental = true;
      };
    };
  };
}
