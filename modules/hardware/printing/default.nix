{
  config,
  lib,
  mkModule,
  ...
}:
mkModule config {
  path = ["hardware" "printing"];
  description = "support for printing (via cups)";
  config = configLocal: {
    services.printing.enable = true;
  };
}
