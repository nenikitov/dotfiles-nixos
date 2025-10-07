# My humble NixOS system config

## Design

This config is very minimal by design.
It contains only system-level options, most necessary programs, and services only.

Almost all of my configuration is done in "user-space" through home-manager.
It can be found in [here](https://github.com/nenikitov/dotfiles), for now in the branch `nix-new`.

## Templates

- Ready to be copy and pasted
- Remove comments starting with `###`
- Preserve comments starting with `#`

### Module

All modules must be defined in `modules/<PATH>/<TO>/<MODULE>/default.nix`.

```nix
{libModule, ...}:
libModule.mkEnableModule {
  path = ["<PATH>" "<TO>" "<MODULE>"];
  description = "<DESCRIPTION>";
  options = {
    ### No need for `enable`
    ### Only additional options here
    ### Skip entirely if no additional options needed
  };
  config = {
    ### No need for check for `enable`
    ### Always try to use set instead of a function
    ### If access to `config` is needed, make this a function
    ### Prefer to use `{configGlobal, ...}:` over `config` argument
  };
}
```

### Host

All hosts must be defined in `hosts/<HOSTNAME>/default.nix` and have a corresponding `host/<HOSTNAME>/hardware.nix` file.

```nix
{customNamespace, ...}: {
  imports = [
    ./hardware.nix
  ];

  # Do not change!
  # Corresponds to the first installed NixOS version
  system.stateVersion = "24.05";

  ### Set if is an EFI system
  boot.loader.efi.canTouchEfiVariables = true;

  ### Select the best profile to use for the machine
  ### Can use multiple profiles
  ${customNamespace} = {
    profiles.desktop.enable = true;
  };

  ### Must-have options
  time.timeZone = "America/Toronto";
}
```

## Inspirations

- [Nebucatnetzer/nixos](https://github.com/Nebucatnetzer/nixos/)
