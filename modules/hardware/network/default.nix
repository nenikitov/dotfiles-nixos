{
  config,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = ["hardware" "network"];
  options = {
    enable = lib.mkEnableOption "support for network (via NetworkManager)";
  };
  config = configLocal:
    lib.mkIf configLocal.enable {
      networking.networkmanager.enable = true;
    };
}
