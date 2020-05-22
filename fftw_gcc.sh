#!/bin/bash
# Author: Shih, Yu-Ting
# Date: 2020/05/22 Fri.
# Desc: To build FFTW 3.3.8 shared library (single precision) with GNU Compiler

CODE_NAME=fftw \
CODE_TAG=3.3.8 \
CODE_DIR=$HOME/$CODE_NAME-$CODE_TAG \
INSTALL_DIR=$HOME/$CODE_NAME-build \
CMAKE_PATH=/usr/bin/cmake \
GCC_PATH=/usr/bin/gcc \
NATIVE_GCC_FLAGS='"-march=native -mtune=native -mavx2 -msse4.2 -O3 -DNDEBUG"' \
GCC_FLAGS='"-march=broadwell -mtune=broadwell -mavx2 -msse4.2 -O3 -DNDEBUG"' \

BUILD_LABEL=$CODE_TAG-shared-gcc840-avx2-broadwell \
CMD_BUILD_SHARED_GCC=" \
    mkdir -p $CODE_DIR/build-$BUILD_LABEL $INSTALL_DIR \
    && cd $CODE_DIR/build-$BUILD_LABEL \
    && $CMAKE_PATH .. \
    -DBUILD_SHARED_LIBS=ON -DENABLE_FLOAT=ON \
    -DENABLE_OPENMP=OFF -DENABLE_THREADS=OFF \
    -DCMAKE_C_COMPILER=$GCC_PATH -DCMAKE_CXX_COMPILER=$GCC_PATH \
    -DENABLE_AVX2=ON -DENABLE_AVX=ON \
    -DENABLE_SSE2=ON -DENABLE_SSE=ON \
    -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR/$BUILD_LABEL \
    -DCMAKE_C_FLAGS_RELEASE=$GCC_FLAGS \
    -DCMAKE_CXX_FLAGS_RELEASE=$GCC_FLAGS \
    && time -p make VERBOSE=1 V=1 install -j \
    && cd $INSTALL_DIR/$BUILD_LABEL && ln -s lib64 lib | tee $BUILD_LABEL.log "

eval $CMD_BUILD_SHARED_GCC
wait
echo $CMD_BUILD_SHARED_GCC