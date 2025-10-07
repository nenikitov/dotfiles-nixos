{customNamespace, ...}: {
  imports = [
    ./hardware.nix
  ];

  # Do not change!
  # Corresponds to the first installed NixOS version
  system.stateVersion = "25.05";

  boot.loader.efi.canTouchEfiVariables = true;

  ${customNamespace} = {
    profiles.graphical.enable = true;
    hardware.nvidia.enable = true;
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
}
