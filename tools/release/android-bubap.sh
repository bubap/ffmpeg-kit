#!/bin/bash

CURRENT_SH_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $CURRENT_SH_DIR/../../

./android.sh --disable-arm-v7a --enable-android-media-codec --enable-android-zlib --enable-dav1d --enable-fontconfig --enable-freetype --enable-fribidi --enable-gmp --enable-gnutls --enable-kvazaar --enable-lame --enable-libass --enable-libiconv --enable-libilbc --enable-libtheora --enable-libvorbis --enable-libvpx --enable-libwebp --enable-libxml2 --enable-opencore-amr --enable-opus --enable-shine --enable-snappy --enable-soxr --enable-speex --enable-twolame --enable-vo-amrwbenc
