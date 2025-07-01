{
  mkModule,
  ...
}:
mkModule {
  path = ["hardware" "nuphy"];
  description = "fix for Nuphy keyboards to enable `F<NUM>` keys";
  config = {
    boot.extraModprobeConfig = ''
      options hid_apple fnmode=2
    '';
  };
}
