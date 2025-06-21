{
  config,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = [ "hardware" "nuphy" ];
  options = {
    enable = lib.mkEnableOption "fix for Nuphy keyboards to enable `F<NUM>` keys" // { default = true; };
  };
  config = configLocal: lib.mkIf configLocal.enable {
    boot.extraModprobeConfig = ''
      options hid_apple fnmode=2
    '';
  };
}
