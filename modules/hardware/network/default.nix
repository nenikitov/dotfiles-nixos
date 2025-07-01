{mkModule, ...}:
mkModule {
  path = ["hardware" "network"];
  description = "support for network (via NetworkManager)";
  config = {
    networking.networkmanager.enable = true;
  };
}
