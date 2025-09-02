#include "nbai/Dialect/NBAI/NBAIOps.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/IR/Builders.h"

using namespace mlir;
using namespace nbai;

#define GET_OP_CLASSES
#include "nbai/Dialect/NBAI/NBAIOps.cpp.inc"

