# Inspirations

https://github.com/Nebucatnetzer/nixos/tree/master

# Template

## Module

```nix
{
  config,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = ["<MODULE>"];
  options = {
    enable = lib.mkEnableOption "<DESCRIPTION>" // { default = <DEFAULT>; };
  };
  config = configLocal: lib.mkIf configLocal.enable {
  };
}
```
