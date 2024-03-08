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


FF_PLATFORM=$1
FF_ACTION=$1

#----------
UNI_BUILD_ROOT=`pwd`/build
UNI_TMP="$UNI_BUILD_ROOT/libs/tmp"
UNI_TMP_LLVM_VER_FILE="$UNI_TMP/llvm.ver.txt"

#----------
FF_LIBS="libssl libcrypto"

#----------
echo_archs() {
    echo "===================="
    echo "[*] check xcode version"
    echo "===================="
}

do_lipo () {
    LIB_FILE=$1
    LIPO_FLAGS=
        LIPO_FLAGS="$LIPO_FLAGS $UNI_BUILD_ROOT/libs/openssl-arm64/output/lib/$LIB_FILE"

    xcrun lipo -create $LIPO_FLAGS -output $UNI_BUILD_ROOT/libs/universal/lib/$LIB_FILE
    xcrun lipo -info $UNI_BUILD_ROOT/libs/universal/lib/$LIB_FILE
}

do_lipo_all () {
    mkdir -p $UNI_BUILD_ROOT/libs/universal/lib
    echo "lipo archs: arm64"
    for FF_LIB in $FF_LIBS
    do
        do_lipo "$FF_LIB.a";
    done
    cp -R $UNI_BUILD_ROOT/libs/openssl-arm64/output/include $UNI_BUILD_ROOT/libs/universal/
}

#----------

if [ "$FF_ACTION" = "build" ]; then
    echo_archs
        sh scripts/do-compile-openssl.sh
    do_lipo_all
elif [ "$FF_ACTION" = "clean" ]; then
    echo_archs
        cd $UNI_BUILD_ROOT/source/openssl-arm64 && git clean -xdf && cd -
else
    echo "Usage:"
    echo "  compile-openssl.sh build"
    echo "  compile-openssl.sh clean"
    exit 1
fi
