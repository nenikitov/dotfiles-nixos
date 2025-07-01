{
  mkModule,
  ...
}:
mkModule {
  path = ["programs" "ly"];
  description = "Ly display manager";
  config = {
    services.displayManager.ly = {
      enable = true;
      settings = {
        clear_password = true;
      };
    };
  };
}
