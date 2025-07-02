{mkModule, ...}:
mkModule {
  path = ["hardware" "nvidia"];
  description = "support for proprietary NVIDIA GPUS (via proprietary drivers)";
  config = {
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
    };
  };
}
