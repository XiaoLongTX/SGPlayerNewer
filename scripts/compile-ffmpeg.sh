#! /usr/bin/env bash
#
# Copyright (C) 2013-2014 Bilibili
# Copyright (C) 2013-2014 Zhang Rui <bbcallen@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#----------
# modify for your build tool

set -e

FF_ACTION=$1

#----------
UNI_BUILD_ROOT=`pwd`/build
UNI_TMP="$UNI_BUILD_ROOT/libs/tmp"
UNI_TMP_LLVM_VER_FILE="$UNI_TMP/llvm.ver.txt"

#----------
SSL_LIBS="libcrypto libssl"
FF_LIBS="libavcodec libavfilter libavformat libavutil libswscale libswresample"

#----------
echo_archs() {
    echo "===================="
    echo "[*] check xcode version"
    echo "===================="
}

do_lipo_ffmpeg () {
    LIB_FILE=$1
    LIPO_FLAGS=
    ARCH_LIB_FILE="$UNI_BUILD_ROOT/libs/ffmpeg-arm64/output/lib/$LIB_FILE"
            if [ -f "$ARCH_LIB_FILE" ]; then
                LIPO_FLAGS="$LIPO_FLAGS $ARCH_LIB_FILE"
            else
                echo "skip $LIB_FILE of arm64";
            fi

    xcrun lipo -create $LIPO_FLAGS -output $UNI_BUILD_ROOT/libs/universal/lib/$LIB_FILE
    xcrun lipo -info $UNI_BUILD_ROOT/libs/universal/lib/$LIB_FILE
}

do_lipo_ssl () {
    LIB_FILE=$1
    LIPO_FLAGS=
    ARCH_LIB_FILE="$UNI_BUILD_ROOT/libs/openssl-arm64/output/lib/$LIB_FILE"
            if [ -f "$ARCH_LIB_FILE" ]; then
                LIPO_FLAGS="$LIPO_FLAGS $ARCH_LIB_FILE"
            else
                echo "skip $LIB_FILE of arm64";
            fi

    if [ "$LIPO_FLAGS" != "" ]; then
        xcrun lipo -create $LIPO_FLAGS -output $UNI_BUILD_ROOT/libs/universal/lib/$LIB_FILE
        xcrun lipo -info $UNI_BUILD_ROOT/libs/universal/lib/$LIB_FILE
    fi
}

do_lipo_all () {
    mkdir -p $UNI_BUILD_ROOT/libs/universal/lib
    echo "lipo archs: arm64"
    for FF_LIB in $FF_LIBS
    do
        do_lipo_ffmpeg "$FF_LIB.a";
    done

    ANY_ARCH=
    ARCH_INC_DIR="$UNI_BUILD_ROOT/libs/ffmpeg-arm64/output/include"
            if [ -d "$ARCH_INC_DIR" ]; then
                if [ -z "$ANY_ARCH" ]; then
                    ANY_ARCH=arm64
                    cp -R "$ARCH_INC_DIR" "$UNI_BUILD_ROOT/libs/universal/"
                fi

                UNI_INC_DIR="$UNI_BUILD_ROOT/libs/universal/include"

                mkdir -p "$UNI_INC_DIR/libavutil/arm64"
                cp -f "$ARCH_INC_DIR/libavutil/avconfig.h"  "$UNI_INC_DIR/libavutil/arm64/avconfig.h"
                cp -f scripts/avconfig.h                    "$UNI_INC_DIR/libavutil/avconfig.h"
                cp -f "$ARCH_INC_DIR/libavutil/ffversion.h" "$UNI_INC_DIR/libavutil/arm64/ffversion.h"
                cp -f scripts/ffversion.h                   "$UNI_INC_DIR/libavutil/ffversion.h"
                mkdir -p "$UNI_INC_DIR/libffmpeg/arm64"
                cp -f "$ARCH_INC_DIR/libffmpeg/config.h"    "$UNI_INC_DIR/libffmpeg/arm64/config.h"
                cp -f scripts/config.h                      "$UNI_INC_DIR/libffmpeg/config.h"
            fi

    for SSL_LIB in $SSL_LIBS
    do
        do_lipo_ssl "$SSL_LIB.a";
    done
}

#----------

if [ "$FF_ACTION" = "build" ]; then
    echo_archs
    sh scripts/do-compile-ffmpeg.sh
    do_lipo_all
elif [ "$FF_ACTION" = "clean" ]; then
    echo_archs
    echo "=================="
    echo "clean ffmpeg-arm64"
    echo "=================="
    cd $UNI_BUILD_ROOT/source/ffmpeg-arm64 && git clean -xdf && cd -
    echo "clean build cache"
    echo "================="
    rm -rf $UNI_BUILD_ROOT/libs/
    rm -rf $UNI_BUILD_ROOT/source/
    echo "clean success"
else
    echo "Usage:"
    echo "  compile-ffmpeg.sh build"
    echo "  compile-ffmpeg.sh clean"
    exit 1
fi

