{
  config,
  customNamespace,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = ["profiles" "desktop"];
  description = "a graphical, desktop profile. Enables `minimal` profile too";
  config = configLocal: {
    "${customNamespace}" = {
      profiles.minimal.enable = true;

      hardware = {
        audio.enable = true;
        bluetooth.enable = true;
        printing.enable = true;
      };
    };

    services.xserver.enable = true;
  };
}
