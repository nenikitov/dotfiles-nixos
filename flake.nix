

{
  description = "Main system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    lib = nixpkgs.lib;
    hosts = ["nenikitov-pc-nix" "nenikitov-laptop-nix"];
    customNamespace = "_ne";
    mkComputer = hostName:
      lib.nixosSystem {
        specialArgs = {
          inherit inputs hostName customNamespace;
          mkModule = configGlobal: {
            path,
            description,
            options ? {},
            config ? configLocal: {},
          }:
            # Options
            (lib.setAttrByPath
              (["options" customNamespace] ++ path)
              (options // { enable = lib.mkEnableOption description; }))
            //
            # Config
            {
              config = let
                configLocal =
                  lib.attrByPath
                  ([customNamespace] ++ path)
                  {}
                  configGlobal;
              in
                lib.mkIf configLocal.enable (config configLocal);
            };
        };
        modules = [
          ./modules
          "${inputs.self}/hosts/${hostName}"
        ];
      };
  in {
    nixosConfigurations =
      lib.pipe
      hosts
      [
        (builtins.map (host: {
          name = host;
          value = mkComputer host;
        }))
        builtins.listToAttrs
      ];
  };
}
