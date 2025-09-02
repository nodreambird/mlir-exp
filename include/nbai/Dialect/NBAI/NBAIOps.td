include "mlir/IR/BuiltinTypes.td"
include "mlir/IR/BuiltinAttributes.td"
include "mlir/IR/OpBase.td"
include "mlir/Interfaces/SideEffectInterfaces.td"
//include "mlir/Interfaces/InferTypeOpInterface.td"
//include "mlir/Interfaces/VectorInterfaces.td"

include "nbai/Dialect/NBAI/NBAI.td"

// A tensor whose element type is one of the above
def NBAI_Tensor : RankedTensorOf<[F16, BF16, F32, F64]>;

def NBAI_ReluOp : Op<NBAIDialect, "relu",
    [Pure]> {
  let summary = "NBAI relu";
  let arguments = (ins NBAI_Tensor:$input);
  let results   = (outs NBAI_Tensor:$result);
  let assemblyFormat = [{
    $input attr-dict `:` type($input) `->` type($result)
  }];
}

def NBAI_MatMulOp : Op<NBAIDialect, "matmul",
    [Pure]> {
  let summary = "NBAI matmul";
  let arguments = (ins NBAI_Tensor:$lhs, NBAI_Tensor:$rhs);
  let results   = (outs NBAI_Tensor:$result);
  let assemblyFormat = [{
    $lhs `,` $rhs attr-dict `:` type($lhs) `,` type($rhs) `->` type($result)
  }];
}

def NBAI_AddOp : Op<NBAIDialect, "add", [Pure]> {
  let summary = "Addition operation for NBAI";
  let description = [{
    Performs element-wise binary addition (with Numpy-style broadcasting support).
    This operator supports multidirectional (i.e., Numpy-style) broadcasting.
    (Opset 14 change): Extend supported types to include int8, int16 and int32.
  }];
  let arguments = (ins
    AnyTypeOf<[TensorOf<[I8]>, TensorOf<[I16]>, TensorOf<[I32]>]>:$A,
    AnyTypeOf<[TensorOf<[I8]>, TensorOf<[I16]>, TensorOf<[I32]>]>:$B
  );
  let results = (outs
    AnyTypeOf<[TensorOf<[I8]>, TensorOf<[I16]>, TensorOf<[I32]>]>:$C
  );
  //let hasVerifier = 1;
  //let hasCanonicalizer = 1;
}

def NBAI_ConvOp : Op<NBAIDialect, "conv", [Pure]> {
  let summary = "convolution operation for NBAI";
  let description = [{
    Perform a convolution over input X with weights W and optional bias B.
    Strides/pads/dilations are integer arrays; group is an integer.
  }];

  let arguments = (ins
    NBAI_Tensor:$X,                    // Input
    NBAI_Tensor:$W,                    // Weights
    Optional<NBAI_Tensor>:$B,          // Optional bias
    I64ArrayAttr:$strides,                 // e.g., [sy, sx]
    I64ArrayAttr:$pads,                    // e.g., [py_top, px_left, py_bot, px_right]
    I64ArrayAttr:$dilations,               // e.g., [dy, dx]
    I64Attr:$group
  );

  let results = (outs NBAI_Tensor:$Y);

  // Nice textual form; keeps types explicit and bias optional
  let assemblyFormat = [{
    $X `,` $W (`,` $B^)? attr-dict `:` type($X) `,` type($W)
      (`,` type($B))? `->` type($Y)
  }];
}

