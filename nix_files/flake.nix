{
  description = "Dev shell for MLIR/NBAI project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        llvmPkgs = pkgs.llvmPackages_18; # or _17 if you need that version
        llvm = llvmPkgs.llvm;
        clang = llvmPkgs.clang;
        mlir = llvmPkgs.mlir;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            clang
            llvm
            mlir
            pkgs.cmake
            pkgs.ninja
            pkgs.lld
            pkgs.git
            pkgs.ccache
            pkgs.python3
            pkgs.vim
          ];

          # Help CMake find LLVM+MLIR automatically
          # (you can omit -DLLVM_DIR/-DMLIR_DIR if CMake respects CMAKE_PREFIX_PATH)
          CMAKE_PREFIX_PATH = pkgs.lib.makeSearchPath "lib/cmake" [
            llvm.dev
            mlir.dev
          ];

          # Make it explicit too (nice for clarity/logs)
          LLVM_DIR = "${llvm.dev}/lib/cmake/llvm";
          MLIR_DIR = "${mlir.dev}/lib/cmake/mlir";

          # Use clang toolchain by default
          CC = "${clang}/bin/clang";
          CXX = "${clang}/bin/clang++";
          LD = "${pkgs.lld}/bin/ld.lld";

          shellHook = ''
            echo "🔧 MLIR dev shell ready"
            echo "  LLVM_DIR=$LLVM_DIR"
            echo "  MLIR_DIR=$MLIR_DIR"
            echo "  CC=$CC"
            echo "  CXX=$CXX"
            echo "Tip: from your project root, run:
              cmake -G Ninja -S . -B build \
                -DCMAKE_BUILD_TYPE=RelWithDebInfo
              cmake --build build -j
            "
          '';
        };
      });
}

