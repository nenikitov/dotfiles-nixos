{
  customNamespace,
  mkModule,
  ...
}:
mkModule {
  path = ["profiles" "graphical"];
  description = "a graphical profile. Enables `minimal` profile too";
  config = {
    "${customNamespace}" = {
      profiles.minimal.enable = true;

      hardware = {
        audio.enable = true;
        bluetooth.enable = true;
        printing.enable = true;
      };

      programs = {
        plymouth.enable = true;
      };
    };

    services.xserver.enable = true;
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
