{
  config,
  options,
  lib,
  pkgs,
  mkModule,
  ...
}:
mkModule config {
  path = ["settings" "locale"];
  options = {
    enable = lib.mkEnableOption "standardized and opinionated locale" // { default = true; };
  };
  config = configLocal: lib.mkIf configLocal.enable {
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LC_ALL = "en.UTF-8";
        LC_COLLATE = "en.UTF-8";
        LC_TIME = "en.UTF-8";
        LC_NUMERIC = "en.UTF-8";
        LC_MONETARY = "en.UTF-8";
        LC_PAPER = "en.UTF-8";
        LC_MEASUREMENT = "en.UTF-8";
        LC_MESSAGES = "en.UTF-8";
        LC_NAME = "en.UTF-8";
        LC_ADDRESS = "en.UTF-8";
        LC_TELEPHONE = "en.UTF-8";
      };

      glibcLocales =
        (pkgs.glibcLocales.override {
          allLocales = false;
          locales = config.i18n.supportedLocales;
        }).overrideAttrs (_: {
          postUnpack = ''
            cp ${./en} $sourceRoot/localedata/locales/en
	    echo 'en.UTF-8/UTF-8 \' >> $sourceRoot/localedata/SUPPORTED
          '';
        });
    };
  };
}
