{
  description = "Development environment with GCC 11, Clang, Ninja, Git, CMake, LLD, ccache, libstdc++, and Vim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.gcc11
            pkgs.gcc11Stdenv
            pkgs.clang
            pkgs.llvmPackages_latest.clang-unwrapped
            pkgs.ninja
            pkgs.git
            pkgs.vim
            pkgs.cmake
            pkgs.lld
            pkgs.ccache
            pkgs.stdenv.cc.cc.lib
            pkgs.zlib
          ];

          shellHook = ''
            export CC="${pkgs.gcc11}/bin/gcc-11"
            export CXX="${pkgs.gcc11}/bin/g++-11"
            export CLANG="${pkgs.llvmPackages_latest.clang-unwrapped}/bin/clang"
            export CLANGXX="${pkgs.llvmPackages_latest.clang-unwrapped}/bin/clang++"
            export NINJA="${pkgs.ninja}/bin/ninja"
            export GIT="${pkgs.git}/bin/git"
            export VIM="${pkgs.vim}/bin/vim"
            export CMAKE="${pkgs.cmake}/bin/cmake"
            export LLD="${pkgs.lld}/bin/lld"
	    export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath [pkgs.stdenv.cc.cc]}

            echo "GCC 11, Clang, Ninja, Git, CMake, LLD, ccache, libstdc++, and Vim are available in this shell."
          '';
        };
      });
}
