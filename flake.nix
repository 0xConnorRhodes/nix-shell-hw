{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages."aarch64-darwin";
  in
  {
    devShells."aarch64-darwin".default = pkgs.mkShell {
      packages = with pkgs; [
        cowsay
      ];

      shellHook = ''
        ps -p $$ # print active shell
      '';

      VAR1 = "123";
      VAR2 = "456";
    };
  };
}
