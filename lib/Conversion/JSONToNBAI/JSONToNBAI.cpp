#include "nbai/Conversion/Passes.h"
#include "nbai/Dialect/NBAI/NBAIDialect.h"
#include "nbai/Dialect/NBAI/NBAIOps.h"

#include "mlir/IR/BuiltinOps.h"
#include "mlir/Transforms/DialectConversion.h"
#include "mlir/IR/PatternMatch.h"

using namespace mlir;
using namespace nbai;

namespace {
struct ReluLowering : public OpConversionPattern</*json::Relu*/ Operation> {
  using OpConversionPattern::OpConversionPattern;
  LogicalResult matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                                ConversionPatternRewriter &rewriter) const override {
    // TODO: replace when you wire actual json types.
    // Placeholder: do nothing.
    return failure();
  }
};
} // namespace

// You will call this from createJSONToNBAIPass() later after you wire json model.

