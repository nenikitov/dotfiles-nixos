# My humble NixOS system config

## Design

This config is very minimal by design.
It contains only system-level options, most necessary programs, and services only.

Almost all of my configuration is done in "user-space" through home-manager.
It can be found in [here](https://github.com/nenikitov/dotfiles), for now in the branch `nix`.

## Templates

- Ready to be copy and pasted
- Remove comments starting with `###`
- Preserve comments starting with `#`

### Module

```nix
{
  config,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = ["<PATH>" "<TO>" "<MODULE>"];
  ### Define only additional options here
  ### No need to create `enable` option - it is done automatically
  options = {
  };
  ### No need to check if the option is enabled and `lib.mkIf` - it is done automatically
  config = configLocal: {
  };
}
```

### Host

```nix
{
  customNamespace,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
  ];

  # Do not change!
  # Corresponds to the first installed NixOS version
  system.stateVersion = "24.05";

  ### Set if is an EFI system
  boot.loader.efi.canTouchEfiVariables = true;

  ### Select the best profile to use for the machine
  "${customNamespace}" = {
    profiles.desktop.enable = true;
  };

  ### Must-have options
  time.timeZone = "America/Toronto";
}
```

## Inspirations

- [Nebucatnetzer/nixos](https://github.com/Nebucatnetzer/nixos/)
