{
  libModule,
  pkgs,
  ...
}:
libModule.mkEnableModule {
  path = ["programs" "plymouth"];
  description = "Plymouth splash screen";
  config = {
    boot.plymouth = {
      enable = true;
      # TODO(nenikitov): Make my own theme?
      theme = "spinner_alt";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = ["spinner_alt"];
        })
      ];
    };
  };
}
