{
  config,
  lib,
  pkgs,
  mkModule,
  ...
}:
mkModule config {
  path = ["settings" "numlock"];
  options = {
    enable = lib.mkEnableOption "num lock at startup" // { default = true; };
  };
  config = configLocal: lib.mkIf configLocal.enable {
    # Early system boot - for disk decryption and TTY
    boot.initrd = {
      extraUtilsCommands = ''
        copy_bin_and_libs ${pkgs.kbd}/bin/setleds
      '';
      preDeviceCommands = ''
        for tty in /dev/tty[1-9]*; do
          /bin/setleds -D +num < "$tty"
        done
      '';
    };

    # Display managers - some like to overwrite it
    services.displayManager.ly.settings.numlock = true;
  };
}
