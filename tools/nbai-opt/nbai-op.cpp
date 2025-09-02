#include "nbai/Conversion/Passes.h"
#include "nbai/Dialect/NBAI/NBAIDialect.h"

#include "mlir/IR/DialectRegistry.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Support/MlirOptMain.h"

using namespace mlir;

int main(int argc, char **argv) {
  DialectRegistry registry;
  // Core MLIR dialects you might load IR with:
  registerAllDialects(registry);

  // Your dialect:
  registry.insert<nbai::NBAIDialect>();

  // Core passes (canonicalize, cse, etc.):
  registerAllPasses();

  // Your passes:
  // PassPipelineRegistration<>(...) later if you want named pipelines.
  // Or rely on -json-to-nbai once registered.

  return failed(MlirOptMain(argc, argv, "NBAI optimizer driver", registry));
}

