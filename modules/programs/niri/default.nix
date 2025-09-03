{libModule, ...}:
libModule.mkEnableModule {
  path = ["programs" "niri"];
  description = "Niri Wayland compositor";
  config = {
    programs.niri.enable = true;
  };
}
