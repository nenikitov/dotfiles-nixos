{
  config,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = ["hardware" "audio"];
  options = {
    enable = lib.mkEnableOption "support for audio (via pipewire / wireplumber)";
  };
  config = configLocal:
    lib.mkIf configLocal.enable {
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
        pulse.enable = true;
        jack.enable = true;
      };
    };
}
