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
  # Define only additional options here
  # No need to create `enable` option - it is done automatically
  options = {
  };
  # No need to check if the option is enabled and `lib.mkIf` - it is done automatically
  config = configLocal: {
  };
}
```
