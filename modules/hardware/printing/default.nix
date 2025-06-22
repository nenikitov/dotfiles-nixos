{
  config,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = ["hardware" "printing"];
  options = {
    enable = lib.mkEnableOption "support for printing (via cups)";
  };
  config = configLocal:
    lib.mkIf configLocal.enable {
      services.printing.enable = true;
    };
}
