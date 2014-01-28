#!/bin/bash

function die {
  echo "$1 failed" && exit 1
}

./clean.sh



for i in x264 ffmpeg; do

  echo
  echo
  echo
  echo "$i CONFIGURE"
  echo
  echo
  echo
  ./configure_${i}.sh || die "$i configure died"

  echo
  echo
  echo
  echo "$i MAKE"
  echo
  echo
  echo
  ./make_${i}.sh || die "$i make died"

done