# Generate pass registration if you later use TableGen registration:
#set(LLVM_TARGET_DEFINITIONS ${CMAKE_CURRENT_SOURCE_DIR}/../../include/nbai/Conversion/Passes.td)
#mlir_tablegen(Passes.h.inc -gen-pass-decls)
#add_public_tablegen_target(MLIRNBAIPassesIncGen)

add_library(NBAIConversion
  Passes.cpp
)

target_link_libraries(NBAIConversion
  PUBLIC
    MLIRNBAI
    MLIRIR
    MLIRPass
    MLIRTransforms
)

add_subdirectory(JSONToNBAI)

