{
  description = "A flake with a multi-arch devShell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    supportedSystems = [ "aarch64-darwin" "x86_64-linux" ];

    # Obtain 'lib' from any one import (arch doesn't matter for lib)
    lib = (import nixpkgs { system = "x86_64-linux"; }).lib;

    makeShell = system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        # default devShell
        default = pkgs.mkShell {
          packages = with pkgs; [ cowsay ];

          shellHook = ''
            echo "This shell is for: ${system}"
          '';

          # ENV
          VAR1 = "123";
          VAR2 = "456";
        };
      };
  in
  {
    devShells = lib.genAttrs supportedSystems (system: makeShell system);
  };
}
