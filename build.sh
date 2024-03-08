#!/bin/sh

set -e

ACTION=$1

FFMPEG_VERSION=dev_for_player
OPENSSL_VERSION=OpenSSL_1_1_1w

if [ "$ACTION" = "build" ]; then
    sh scripts/init-openssl.sh $OPENSSL_VERSION
    sh scripts/init-ffmpeg.sh $FFMPEG_VERSION
    sh scripts/compile-openssl.sh "build"
    sh scripts/compile-ffmpeg.sh "build"
elif [ "$ACTION" = "clean" ]; then
    sh scripts/compile-openssl.sh "clean"
    sh scripts/compile-ffmpeg.sh "clean"
else
    echo "Usage:"
    echo "  build.sh build"
    echo "  build.sh clean"
    exit 1
fi
