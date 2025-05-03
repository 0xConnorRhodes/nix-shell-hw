{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  packages = with pkgs; [
    cowsay
  ];

  inputsFrom = [pkgs.bat];

  shellHook = ''
    ps -p $$ # print active shell
  '';

  # ENV
  VAR1 = "123";
  VAR2 = "456";

  LD_LIBRARY_PATH =
    "${pkgs.lib.makeLibraryPath [pkgs.ncurses]}";
  
  RUST_BACKTRACE = 1;
}

