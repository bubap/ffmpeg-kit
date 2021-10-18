#!/bin/bash

CURRENT_SH_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $CURRENT_SH_DIR/../../

./ios.sh --xcframework --disable-armv7 --disable-armv7s --disable-i386 --disable-arm64e --enable-ios-audiotoolbox --enable-ios-avfoundation --enable-ios-bzip2 --enable-ios-libiconv --enable-ios-videotoolbox --enable-ios-zlib --enable-dav1d --enable-fontconfig --enable-freetype --enable-fribidi --enable-gmp --enable-gnutls --enable-kvazaar --enable-lame --enable-libass --enable-libilbc --enable-libtheora --enable-libvorbis --enable-libvpx --enable-libwebp --enable-libxml2 --enable-opencore-amr --enable-opus --enable-shine --enable-snappy --enable-soxr --enable-speex --enable-twolame --enable-vo-amrwbenc --disable-x86-64-mac-catalyst --disable-arm64-mac-catalyst --enable-openh264

zip -r "./prebuilt/ffmpeg-kit-bubap-ios-xcframework.zip" ./prebuilt/bundle-apple-xcframework-ios/* || exit 1
