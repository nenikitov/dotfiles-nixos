{
  description = "Main system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... } @ inputs:
  let
    lib = nixpkgs.lib;
    hosts = ["nenikitov-pc-nix"];
    customNamespace = "_ne";
    mkComputer = hostName: lib.nixosSystem {
      specialArgs = {
        inherit inputs hostName customNamespace;
        mkModule = configGlobal: {
          path,
          options ? {},
          config ? configLocal: {}
        }:
          (lib.setAttrByPath (["options" customNamespace] ++ path) options)
          // {
            config = config (lib.attrByPath ([customNamespace] ++ path) {} configGlobal);
          };
      };
      modules = [
        ./modules
        "${inputs.self}/hosts/_default"
        "${inputs.self}/hosts/${hostName}"
      ];
    };
  in
  {
    nixosConfigurations = lib.pipe
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
