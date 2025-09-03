add_mlir_tool(nbai-opt
  nbai-opt.cpp
)

target_link_libraries(nbai-opt
  PRIVATE
    MLIRNBAI
    NBAIConversion
    JSONToNBAI
    MLIRIR
    MLIRParser
    MLIRPass
    MLIRSupport
    MLIRTransforms
)

