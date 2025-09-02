#include "nbai/Conversion/Passes.h"
#include "mlir/Pass/Pass.h"

using namespace mlir;

namespace {
struct JSONToNBAIPassImpl : public PassWrapper<JSONToNBAIPassImpl, OperationPass<ModuleOp>> {
  void runOnOperation() override {
    // TODO: add DialectConversion here.
  }
};
} // namespace

std::unique_ptr<Pass> createJSONToNBAIPass() {
  return std::make_unique<JSONToNBAIPassImpl>();
}

