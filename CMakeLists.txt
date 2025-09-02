cmake_minimum_required(VERSION 3.20.0)

project(mlir-exp LANGUAGES CXX C)

set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard")
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(BUILD_DEPS ON)

find_package(LLVM REQUIRED CONFIG)
find_package(MLIR REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using MLIRConfig.cmake in: ${MLIR_DIR}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

# LLVM/MLIR CMake helpers
list(APPEND CMAKE_MODULE_PATH
  "${LLVM_CMAKE_DIR}"
  "${MLIR_CMAKE_DIR}"
)

include(TableGen)
include(AddLLVM)
include(HandleLLVMOptions)
include(MLIRTableGen)
include(AddMLIR)

# LLVM/MLIR use these defines
add_definitions(${LLVM_DEFINITIONS})
include_directories(SYSTEM ${LLVM_INCLUDE_DIRS} ${MLIR_INCLUDE_DIRS})
link_directories(${LLVM_LIBRARY_DIRS})

# So we can do #include "nbai/…"
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

# Enable folders in IDEs
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Subdirs
add_subdirectory(lib)
add_subdirectory(tools)


##set(MLIR_SRC_DIR "${CMAKE_SOURCE_DIR}/external/mlir/build/lib/cmake/mlir")
#set(MLIR_BINARY_DIR ${CMAKE_BINARY_DIR})
#
#
#list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")
#
#include_directories(${LLVM_INCLUDE_DIRS})
#include_directories(${MLIR_INCLUDE_DIRS})
#include_directories(${PROJECT_SOURCE_DIR})
#include_directories(${PROJECT_SOURCE_DIR}/externals/llvm-project)
#include_directories(${PROJECT_BINARY_DIR})
#
#add_subdirectory(external/mlir/llvm EXCLUDE_FROM_ALL)
#add_subdirectory(external/mlir)
#add_subdirectory(tests)
#add_subdirectory(tools)
#add_subdirectory(lib)
