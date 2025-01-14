#!/bin/bash

# UPDATE BUILD FLAGS
export FREETYPE_CFLAGS="$(pkg-config --cflags freetype2 --dont-define-prefix)"
export FREETYPE_LIBS="$(pkg-config --libs --static freetype2 --dont-define-prefix)"
export FRIBIDI_CFLAGS="$(pkg-config --cflags fribidi --dont-define-prefix)"
export FRIBIDI_LIBS="$(pkg-config --libs --static fribidi --dont-define-prefix)"
export FONTCONFIG_CFLAGS="$(pkg-config --cflags fontconfig --dont-define-prefix)"
export FONTCONFIG_LIBS="$(pkg-config --libs --static fontconfig --dont-define-prefix)"
export HARFBUZZ_CFLAGS="$(pkg-config --cflags harfbuzz --dont-define-prefix)"
export HARFBUZZ_LIBS="$(pkg-config --libs --static harfbuzz --dont-define-prefix)"
export LIBPNG_CFLAGS="$(pkg-config --cflags libpng --dont-define-prefix)"
export LIBPNG_LIBS="$(pkg-config --libs --static libpng --dont-define-prefix)"

# SET BUILD OPTIONS
ASM_OPTIONS=""
case ${ARCH} in
x86)

  # please note that asm is disabled
  # enabling asm for x86 causes text relocations in libavfilter.so
  ASM_OPTIONS="	--disable-asm"
  ;;
*)
  ASM_OPTIONS="	--enable-asm"
  ;;
esac

# ALWAYS CLEAN THE PREVIOUS BUILD
make distclean 2>/dev/null 1>/dev/null

# REGENERATE BUILD FILES IF NECESSARY OR REQUESTED
if [[ ! -f "${BASEDIR}"/src/"${LIB_NAME}"/configure ]] || [[ ${RECONF_libass} -eq 1 ]]; then
  autoreconf_library "${LIB_NAME}"
fi

./configure \
  --prefix="${LIB_INSTALL_PREFIX}" \
  --with-pic \
  --with-sysroot="${ANDROID_SYSROOT}" \
  --disable-libtool-lock \
  --enable-static \
  --disable-shared \
  --disable-require-system-font-provider \
  --disable-fast-install \
  --disable-test \
  --disable-profile \
  --disable-coretext \
  ${ASM_OPTIONS} \
  --host="${HOST}" || return 1

make -j$(get_cpu_count) || return 1

make install || return 1

# MANUALLY COPY PKG-CONFIG FILES
cp ./*.pc "${INSTALL_PKG_CONFIG_DIR}" || return 1
