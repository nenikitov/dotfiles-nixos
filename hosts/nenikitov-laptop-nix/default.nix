{
  pkgs,
  customNamespace,
  ...
}: {
  imports = [
    ./hardware.nix
  ];

  # Do not change!
  # Corresponds to the first installed NixOS version
  system.stateVersion = "24.05";

  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."~nenikitov/Shared" = {
    device = "/dev/nvme0n1p5";
    options = ["rw" "uid=1000"];
  };

  "${customNamespace}" = {
    profiles.graphical.enable = true;
    programs.systemdBoot.extraEntries = {
      "grub.conf" = ''
        title GRUB
        efi /EFI/GRUB/grubx64.efi
      '';
    };
  };

  time.timeZone = "America/Toronto";
  services.xserver.xkb = {
    layout = "us";
  };

  users.users.nenikitov.shell = pkgs.zsh;
  programs.zsh.enable = true;

  services.desktopManager.plasma6.enable = true;
}
