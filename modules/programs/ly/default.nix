{
  config,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = ["programs" "ly"];
  description = "Ly display manager";
  config = configLocal: {
    services.displayManager.ly = {
      enable = true;
      settings = {
        clear_password = true;
      };
    };
  };
}
