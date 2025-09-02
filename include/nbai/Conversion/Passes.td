include "mlir/Pass/PassBase.td"

def JSONToNBAIPass : Pass<"json-to-nbai", "mlir::ModuleOp"> {
  let summary = "Convert ops in json to NBAI ops";
  let constructor = "createJSONToNBAIPass()";
}

