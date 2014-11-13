#!/bin/bash
pushd `dirname $0`
. settings.sh

if [[ $DEBUG == 1 ]]; then
  echo "DEBUG = 1"
  DEBUG_FLAG="--disable-stripping"
fi

patch -N -d ffmpeg -p1 --reject-file=- < ./ffmpeg-configure.patch

pushd ffmpeg

./configure \
$DEBUG_FLAG \
--arch=arm \
--cpu=cortex-a8 \
--target-os=linux \
--enable-runtime-cpudetect \
--prefix=$prefix \
--enable-pic \
--disable-shared \
--enable-static \
--cross-prefix=$NDK_TOOLCHAIN_BASE/bin/$NDK_ABI-linux-androideabi- \
--sysroot="$NDK_SYSROOT" \
--extra-cflags="-I../x264 -mfloat-abi=softfp -mfpu=neon $CFLAGS" \
--extra-ldflags="-L../x264 $LDFLAGS" \
\
--enable-version3 \
--enable-gpl \
\
--disable-doc \
--enable-yasm \
\
--disable-indevs \
--disable-outdevs \
\
--enable-hwaccels \
\
--enable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
--disable-network \
\
--enable-libx264 \
--enable-zlib \
\
--disable-filters \
--enable-filter=transpose \
--enable-filter=hflip \
--enable-filter=vflip \
--enable-filter=scale \
--enable-filter=crop \
--enable-filter=cropdetect \
\
--disable-encoders \
--disable-decoders \
--disable-protocols \
--disable-muxers \
--disable-demuxers \
--disable-parsers \
--disable-devices \
--enable-decoder=mp3 \
--enable-decoder=vorbis \
--enable-decoder=alac \
--enable-encoder=mpeg4 \
--enable-decoder=mpeg4 \
--enable-decoder=vp8 \
--enable-decoder=flac \
--enable-decoder=pcm_s8 \
--enable-decoder=pcm_u8 \
--enable-decoder=h264 \
--enable-decoder=h263 \
--enable-encoder=libx264 \
--enable-decoder=libx264 \
--enable-encoder=adpcm_swf \
--enable-decoder=adpcm_swf \
--enable-encoder=nellymoser \
--enable-decoder=nellymoser \
--enable-encoder=flv \
--enable-decoder=flv \
--enable-encoder=aac \
--enable-decoder=aac \
--enable-decoder=amrnb \
--enable-decoder=amrwb \
--enable-encoder=pcm_s16le \
--enable-decoder=pcm_s16le \
--enable-muxer=amr \
--enable-demuxer=amr \
--enable-muxer=flv \
--enable-demuxer=flv \
--enable-muxer=pcm_s16le \
--enable-demuxer=pcm_s16le \
--enable-muxer=wav \
--enable-demuxer=wav \
--enable-muxer=matroska \
--enable-demuxer=matroska \
--enable-muxer=matroska_audio \
--enable-demuxer=matroska_audio \
--enable-muxer=m4v \
--enable-demuxer=m4v \
--enable-muxer=mov \
--enable-demuxer=mov \
--enable-muxer=h263 \
--enable-demuxer=h263 \
--enable-muxer=h264 \
--enable-demuxer=h264 \
--enable-muxer=webm \
--enable-demuxer=webm \
--enable-muxer=ogg \
--enable-demuxer=ogg \
--enable-muxer=flac \
--enable-demuxer=flac \
--enable-muxer=mpegts \
--enable-demuxer=mpegts \
--enable-muxer=mpegtsraw \
--enable-demuxer=mpegtsraw \
--enable-muxer=aac \
--enable-demuxer=aac \
--enable-muxer=mp4 \
--enable-parser=aac \
--enable-parser=h263 \
--enable-parser=h264 \
--enable-parser=vp8 \
--enable-parser=mpegvideo \
--enable-parser=mpegaudio \
--enable-parser=mpeg4video \
--enable-parser=flac \
--enable-protocol=rtmps \
--enable-protocol=rtmpt \
--enable-protocol=crypto \
--enable-protocol=rtmpte \
--enable-protocol=file \
--enable-protocol=pipe \
--enable-protocol=rtp \
--enable-protocol=rtmp \
--enable-protocol=tcp \
--enable-protocol=http \
--enable-protocol=rtmpe \
--enable-protocol=udp

popd; popd


