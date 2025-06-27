{
  config,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = ["hardware" "network"];
  description = "support for network (via NetworkManager)";
  config = configLocal: {
    networking.networkmanager.enable = true;
  };
}
