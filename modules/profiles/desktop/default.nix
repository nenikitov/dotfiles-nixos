{
  config,
  customNamespace,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = ["profiles" "desktop"];
  options = {
    enable = lib.mkEnableOption "a graphical, desktop profile. Enables `minimal` profile too";
  };
  config = configLocal:
    lib.mkIf configLocal.enable {
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
