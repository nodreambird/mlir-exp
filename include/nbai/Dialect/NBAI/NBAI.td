include "mlir/IR/DialectBase.td"

def NBAIDialect : Dialect {
  let name = "nbai";
  let cppNamespace = "::nbai";
  let summary = "nbai dialect";
  let description = [{
    This dialect contains operations and types specific to the NBAI domain.
  }];
}


