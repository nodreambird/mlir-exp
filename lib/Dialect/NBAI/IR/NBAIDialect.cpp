#include "nbai/Dialect/NBAI/NBAIDialect.h"
#include "nbai/Dialect/NBAI/NBAIOps.h"
#include "mlir/IR/DialectImplementation.h"

using namespace mlir;
using namespace eai;

#include "nbai/Dialect/NBAI/NBAIDialect.cpp.inc"

void NBAIDialect::initialize() {
  addOperations<
#define GET_OP_LIST
#include "nbai/Dialect/NBAI/NBAIOps.cpp.inc"
  >();
}

