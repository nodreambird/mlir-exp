
set(LLVM_TARGET_DEFINITIONS ${PROJECT_SOURCE_DIR}/include/nbai/Dialect/NBAI/NBAIOps.td)
mlir_tablegen(NBAIOps.h.inc -gen-op-decls)
mlir_tablegen(NBAIOps.cpp.inc -gen-op-defs)
add_public_tablegen_target(MLIRNBAIOpsIncGen)

set(LLVM_TARGET_DEFINITIONS ${PROJECT_SOURCE_DIR}/include/nbai/Dialect/NBAI/NBAI.td)
mlir_tablegen(NBAIDialect.h.inc -gen-dialect-decls -dialect=nbai)
mlir_tablegen(NBAIDialect.cpp.inc -gen-dialect-defs -dialect=nbai)
add_public_tablegen_target(MLIRNBAIDialectIncGen)

add_mlir_dialect_library(MLIRNBAI
  IR/NBAIDialect.cpp
  IR/NBAIOps.cpp

  DEPENDS
    MLIRNBAIDialectIncGen
    MLIRNBAIOpsIncGen

  LINK_LIBS PUBLIC
    MLIRIR
)

target_include_directories(MLIRNBAI
  PUBLIC
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
)
