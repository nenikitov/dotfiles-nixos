{
  config,
  pkgs,
  customNamespace,
  ...
}: {
  imports = [
    ./hardware.nix
  ];

  "${customNamespace}" = {
    profiles.desktop.enable = true;
  };

  time.timeZone = "America/Toronto";
  services.xserver.xkb = {
    layout = "us";
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      editor = false;
      extraEntries = {
        "grub.conf" = ''
          title GRUB
          efi /EFI/GRUB/grubx64.efi
        '';
      };
    };
    efi.canTouchEfiVariables = true;
  };

  fileSystems."~nenikitov/Shared" = {
    device = "/dev/nvme0n1p5";
    options = ["rw" "uid=1000"];
  };

  users.users.nenikitov.shell = pkgs.zsh;
  programs.zsh.enable = true;

  services.displayManager.ly = {
    enable = true;
    settings = {
      clear_password = true;
      clock = "%Y-%m-%d, %H:%M:%S";
    };
  };
  services.desktopManager.plasma6.enable = true;

  # Do not change
  # Corresponds to the first installed NixOS version
  system.stateVersion = "24.05";
}
