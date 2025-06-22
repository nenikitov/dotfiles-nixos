{
  config,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = ["users" "nenikitov"];
  options = {
    enable = lib.mkEnableOption "creation of a `nenikitov` user profile";
  };
  config = configLocal:
    lib.mkIf configLocal.enable {
      users.users.nenikitov = {
        isNormalUser = true;
        description = "Myk";
        extraGroups = ["networkmanager" "wheel"];
      };
    };
}
