{
  libModule,
  pkgs,
  ...
}:
libModule.mkEnableModule {
  path = ["profiles" "graphical"];
  description = "a graphical profile. Enables `minimal` profile too";
  config = {namespace, ...}: {
    ${namespace} = {
      profiles.minimal.enable = true;

      hardware = {
        audio.enable = true;
        bluetooth.enable = true;
        printing.enable = true;
      };

      programs = {
        plymouth.enable = true;
        niri.enable = true;
      };
    };

    services.xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];
    };
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
