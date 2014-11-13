#!/bin/bash

# set the base path to your Android NDK (or export NDK to environment)

if [[ "x$NDK_BASE" == "x" ]]; then
    NDK_BASE=/opt/android-ndk
    echo "No NDK_BASE set, using $NDK_BASE"
fi

# Android now has 64-bit and 32-bit versions of the NDK for GNU/Linux.  We
# assume that the build platform uses the appropriate version, otherwise the
# user building this will have to manually set NDK_PROCESSOR or NDK_TOOLCHAIN.
if [ $(uname -m) = "x86_64" ]; then
    NDK_PROCESSOR=x86_64
else
    NDK_PROCESSOR=x86
fi

# Android NDK setup
NDK_PLATFORM_LEVEL=14
NDK_ABI=arm
NDK_COMPILER_VERSION=4.8
NDK_SYSROOT=$NDK_BASE/platforms/android-$NDK_PLATFORM_LEVEL/arch-$NDK_ABI
NDK_UNAME=`uname -s | tr '[A-Z]' '[a-z]'`
if [ $NDK_ABI = "x86" ]; then
    HOST=i686-linux-android
    NDK_TOOLCHAIN=$NDK_ABI-$NDK_COMPILER_VERSION
else
    HOST=$NDK_ABI-linux-androideabi
    NDK_TOOLCHAIN=$HOST-$NDK_COMPILER_VERSION
fi
NDK_TOOLCHAIN_BASE=$NDK_BASE/toolchains/$NDK_TOOLCHAIN/prebuilt/$NDK_UNAME-$NDK_PROCESSOR

CC="$NDK_TOOLCHAIN_BASE/bin/$HOST-gcc --sysroot=$NDK_SYSROOT"
LD=$NDK_TOOLCHAIN_BASE/bin/$HOST-ld
STRIP=$NDK_TOOLCHAIN_BASE/bin/$HOST-strip

CWD=`pwd`
PROJECT_ROOT=$CWD
EXTERNAL_ROOT=$PROJECT_ROOT

# install root for built files
DESTDIR=$EXTERNAL_ROOT
prefix=/build/
LOCAL=$DESTDIR$prefix

CFLAGS="-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -fno-strict-overflow -fstack-protector-all -fPIC -fpic"
LDFLAGS="-Wl,-z,relro -Wl,-z,now -pie"
