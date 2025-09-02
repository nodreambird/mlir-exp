add_library(JSONToNBAI
  JSONToNBAI.cpp
)

target_link_libraries(JSONToNBAI
  PUBLIC
    NBAIConversion
    MLIRNBAI
    MLIRIR
    MLIRPass
    MLIRTransforms
    # Add the json dialect libs when you integrate them:
    # MLIRJSONOps
    # MLIRJSONToKrnl (onnx-mlir) etc.
)

