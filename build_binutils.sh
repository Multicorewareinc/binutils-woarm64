#!/bin/bash
set -e
set -x


export TOOLCHAIN_PATH=/home/HCKTest/file2/toolchain/aarch64-pc-cygwin
export SOURCE_PATH=/home/HCKTest/file2/binutils-woarm64-own
export BUILD_PATH=/home/HCKTest/file2/build


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

make install-bfd install-libiberty

