{mkModule, ...}:
mkModule {
  path = ["users" "nenikitov"];
  description = "creation of a `nenikitov` user profile";
  config = {
    users.users.nenikitov = {
      isNormalUser = true;
      description = "Myk";
      extraGroups = ["networkmanager" "wheel"];
    };
  };
}
