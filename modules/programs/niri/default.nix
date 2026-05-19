{libModule, ...}:
libModule.mkEnableModule {
  path = ["programs" "niri"];
  description = "niri Wayland compositor";
  config = {
    programs.niri.enable = true;
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
  };
}
