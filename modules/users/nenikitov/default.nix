{
  config,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = ["users" "nenikitov"];
  description = "creation of a `nenikitov` user profile";
  config = configLocal: {
    users.users.nenikitov = {
      isNormalUser = true;
      description = "Myk";
      extraGroups = ["networkmanager" "wheel"];
    };
  };
}
