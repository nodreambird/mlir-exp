#pragma once
#include "mlir/Pass/Pass.h"

std::unique_ptr<mlir::Pass> createJSONToNBAIPass();

// Generated pass registration (optional later):
// #include "nbai/Conversion/Passes.h.inc"

