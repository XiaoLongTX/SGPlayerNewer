#! /usr/bin/env bash
#
# Copyright (C) 2013-2015 Bilibili
# Copyright (C) 2013-2015 Zhang Rui <bbcallen@gmail.com>
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

FFMPEG_UPSTREAM=https://github.com/XiaoLongTX/FFmpeg.git
FFMPEG_COMMIT=$1
FFMPEG_LOCAL_REPO=~/FFmpeg

GASP_UPSTREAM=https://github.com/libav/gas-preprocessor.git
GASP_LOCAL_REPO=build/gas-preprocessor

set -e

function pull_common() {
    echo "== pull gas-preprocessor base =="
    sh scripts/pull-repo-base.sh $GASP_UPSTREAM $GASP_LOCAL_REPO

    echo "== pull ffmpeg base =="
    sh scripts/pull-repo-base.sh $FFMPEG_UPSTREAM $FFMPEG_LOCAL_REPO
}

function pull_fork() {
    echo "== pull ffmpeg fork arm64 =="
    sh scripts/pull-repo-ref.sh $FFMPEG_UPSTREAM build/source/ffmpeg-arm64 ${FFMPEG_LOCAL_REPO}
    cd build/source/ffmpeg-arm64
    git checkout ${FFMPEG_COMMIT} -B SGPlayer
    cd -
}

pull_common
pull_fork

