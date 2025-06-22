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
  path = ["<PATH>" "<TO>" "<MODULE>"];
  options = {
    enable = lib.mkEnableOption "<DESCRIPTION>";
  };
  config = configLocal:
    lib.mkIf configLocal.enable {
    };
}
```
