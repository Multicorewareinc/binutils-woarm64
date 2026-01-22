#!/bin/bash
set -e
set -x

git clone https://github.com/thiru-mcw/binutils-woarm64-own.git binutils

export TOOLCHAIN_PATH="$PWD/toolchain/aarch64-pc-cygwin"
export SOURCE_PATH="$PWD/binutils"
export BUILD_PATH="$PWD/build"


export CC=aarch64-pc-cygwin-gcc
export CXX=aarch64-pc-cygwin-g++
export AR=aarch64-pc-cygwin-ar
export RANLIB=aarch64-pc-cygwin-ranlib
export NM=aarch64-pc-cygwin-nm
export OBJDUMP=aarch64-pc-cygwin-objdump
export STRIP=aarch64-pc-cygwin-strip


unset CFLAGS
unset CXXFLAGS
unset LDFLAGS


mkdir -p $BUILD_PATH
cd $BUILD_PATH

    # --enable-install-libbfd \
    #    --enable-64-bit-bfd \
    #    --disable-gdbserver
        #--enable-targets=all \

echo "=== Configuring native BFD for aarch64-pc-cygwin ==="
$SOURCE_PATH/configure \
    --prefix=$TOOLCHAIN_PATH \
    --build=x86_64-pc-cygwin \
    --host=aarch64-pc-cygwin \
    --target=aarch64-pc-cygwin \
    --enable-targets=aarch64-pc-cygwin \
    --enable-64-bit-bfd \
    --enable-static \
    --disable-shared \
    --disable-werror \
    --with-sysroot=$TOOLCHAIN_PATH \
    --disable-nls \
    --disable-gdb \
    --disable-libdecnumber \
    --disable-readline \
    --disable-sim \
    --disable-gdbserver


make -j$(nproc)

cp build/bfd/libbfd.a "$TOOLCHAIN_PATH/lib"
cp build/libiberty/libiberty.a "$TOOLCHAIN_PATH/lib"
cp build/libsframe/libsframe.a "$TOOLCHAIN_PATH/lib"
cp build/zlib/libz.a "$TOOLCHAIN_PATH/lib"

cp build/bfd/bfd.h "$TOOLCHAIN_PATH/aarch64-pc-cygwin/include"
cp binutils/include/diagnostics.h "$TOOLCHAIN_PATH/aarch64-pc-cygwin/include"


echo "===========Please add libiconv and libintl in $TOOLCHAIN_PATH/lib================"