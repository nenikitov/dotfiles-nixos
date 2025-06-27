{
  config,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = ["hardware" "audio"];
  description = "support for audio (via pipewire / wireplumber)";
  config = configLocal: {
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
