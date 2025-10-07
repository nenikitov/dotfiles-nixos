{pkgs, ...}: {
  projectRootFile = "flake.nix";

  programs = {
    actionlint.enable = true;
    alejandra.enable = true;
    mdformat = {
      enable = true;
      package = pkgs.mdformat.withPlugins (p:
        with p; [
          mdformat-gfm
          mdformat-gfm-alerts
          mdformat-tables
          mdformat-simple-breaks
        ]);
    };
    nixf-diagnose.enable = true;
  };
}
