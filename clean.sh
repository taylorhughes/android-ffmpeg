#!/bin/bash
pushd `dirname $0`
. settings.sh

find . -name \*.o -delete

for i in x264 ffmpeg; do

  pushd $i
  make clean
  popd

done
