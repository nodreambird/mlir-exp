include "NBAI.td"
include "mlir/IR/OpBase.td"
include "mlir/IR/BuiltinTypes.td"
include "mlir/Interfaces/InferTypeOpInterface.td"
include "mlir/Interfaces/VectorInterfaces.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

def NBAI_ReluOp : Op<NBAIDialect, "relu",
    [NoSideEffect]> {
  let summary = "NBAI relu";
  let arguments = (ins AnyTensor:$input);
  let results   = (outs AnyTensor:$result);
  let assemblyFormat = [{
    $input attr-dict `:` type($input) `->` type($result)
  }];
}

def NBAI_MatMulOp : Op<NBAIDialect, "matmul",
    [NoSideEffect]> {
  let summary = "NBAI matmul";
  let arguments = (ins AnyTensor:$lhs, AnyTensor:$rhs);
  let results   = (outs AnyTensor:$result);
  let assemblyFormat = [{
    $lhs `,` $rhs attr-dict `:` type($lhs) `,` type($rhs) `->` type($result)
  }];
}

def NBAI_AddOp : Op<"add", [NoSideEffect]> {
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

def NBAI_ConvOp : Op<"conv", [NoSideEffect]> {
  let summary = "convolution operation for NBAI";
  let description = [{
    perform convolution
  }];

  let arguments = (ins
    TensorOf<[F32, F64, ...]>:$X,       // Input tensor
    TensorOf<[F32, F64, ...]>:$W,       // Weight tensor
    Optional<TensorOf<[F32, F64, ...]>>:$B, // Optional bias
    ArrayAttr:$strides,
    ArrayAttr:$pads,
    ArrayAttr:$dilations,
    IntegerAttr:$group
  );
  let results = (outs TensorOf<[F32, F64, ...]>:$Y); // Output tensor
}

