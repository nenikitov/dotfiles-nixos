{
  pkgs,
  libModule,
  ...
}:
libModule.mkEnableModule {
  path = ["settings" "numlock"];
  description = "num lock at startup";
  config = {
    # Early system boot - for disk decryption and TTY
    boot.initrd = {
      extraUtilsCommands =
        # sh
        ''
          copy_bin_and_libs ${pkgs.kbd}/bin/setleds
        '';
      preDeviceCommands =
        # sh
        ''
          for tty in /dev/tty[1-9]*; do
            /bin/setleds -D +num < "$tty"
          done
        '';
    };

    # Display managers - some like to overwrite it
    services.displayManager.ly.settings.numlock = true;
  };
}
