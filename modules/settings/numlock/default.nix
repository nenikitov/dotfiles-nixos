{
  libModule,
  pkgs,
  ...
}:
libModule.mkEnableModule {
  path = ["settings" "numlock"];
  description = "num lock at startup";
  config = {
    # Early system boot - for disk decryption and TTY
    boot.initrd.systemd = {
      # https://discourse.nixos.org/t/how-to-enable-num-lock-for-the-disk-decryption-passphrase/40625/7
      storePaths = [
        "${pkgs.kbd}/bin/setleds"
      ];
      services.numlock-on = {
        description = "Enable NumLock at startup";
        wantedBy = [ "initrd.target" ];
        before = [ "initrd-root-device.target" ];
        unitConfig = { DefaultDependencies = false; };
        script = #sh
        ''
          for tty in /dev/tty[1-9]*; do
            ${pkgs.kbd}/bin/setleds -D +num < "$tty"
          done
        '';
      };
    };

    # Display managers - some like to overwrite it
    services.displayManager.ly.settings.numlock = true;
  };
}
