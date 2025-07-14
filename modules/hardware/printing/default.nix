{libModule, ...}:
libModule.mkEnableModule {
  path = ["hardware" "printing"];
  description = "support for printing (via cups)";
  config = {
    services.printing.enable = true;
  };
}
