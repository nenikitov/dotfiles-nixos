{libModule, ...}:
libModule.mkEnableModule {
  path = ["hardware" "audio"];
  description = "support for audio (via pipewire / wireplumber)";
  config = {
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
