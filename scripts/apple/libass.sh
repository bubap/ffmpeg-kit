#!/bin/bash

# UPDATE BUILD FLAGS
export FREETYPE_CFLAGS="$(pkg-config --dont-define-prefix --cflags freetype2)"
export FREETYPE_LIBS="$(pkg-config --dont-define-prefix --libs --static freetype2)"
export FRIBIDI_CFLAGS="$(pkg-config --dont-define-prefix --cflags fribidi)"
export FRIBIDI_LIBS="$(pkg-config --dont-define-prefix --libs --static fribidi)"
export FONTCONFIG_CFLAGS="$(pkg-config --dont-define-prefix --cflags fontconfig)"
export FONTCONFIG_LIBS="$(pkg-config --dont-define-prefix --libs --static fontconfig)"
export HARFBUZZ_CFLAGS="$(pkg-config --dont-define-prefix --cflags harfbuzz)"
export HARFBUZZ_LIBS="$(pkg-config --dont-define-prefix --libs --static harfbuzz)"
export LIBPNG_CFLAGS="$(pkg-config --dont-define-prefix --cflags libpng)"
export LIBPNG_LIBS="$(pkg-config --dont-define-prefix --libs --static libpng)"

# SET BUILD OPTIONS
ASM_OPTIONS="--enable-asm"
case ${ARCH} in
x86-64 | x86-64-mac-catalyst)
  ASM_OPTIONS="--disable-asm"
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
  --with-sysroot="${SDK_PATH}" \
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
