{libModule, ...}:
libModule.mkEnableModule {
  path = ["programs" "niri"];
  description = "niri Wayland compositor";
  config = {
    programs.niri.enable = true;
  };
}
