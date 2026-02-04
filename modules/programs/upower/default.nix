{libModule, ...}:
libModule.mkEnableModule {
  path = ["programs" "upower"];
  description = "Upower power management service";
  config = {
    services.upower = {
      enable = true;
    };
  };
}

