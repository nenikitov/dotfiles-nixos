{
  config,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = ["hardware" "nuphy"];
  description = "fix for Nuphy keyboards to enable `F<NUM>` keys";
  config = configLocal: {
    boot.extraModprobeConfig = ''
      options hid_apple fnmode=2
    '';
  };
}
