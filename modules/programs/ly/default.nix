{
  config,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = ["programs" "ly"];
  options = {
    enable = lib.mkEnableOption "Ly display manager";
  };
  config = configLocal:
    lib.mkIf configLocal.enable {
      services.displayManager.ly = {
        enable = true;
        settings = {
          clear_password = true;
        };
      };
    };
}
