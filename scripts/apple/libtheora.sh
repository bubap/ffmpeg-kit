#!/bin/bash

# UPDATE BUILD FLAGS
export OGG_CFLAGS="$(pkg-config --dont-define-prefix --cflags ogg)"
export OGG_LIBS="$(pkg-config --dont-define-prefix --libs --static ogg)"

# ALWAYS CLEAN THE PREVIOUS BUILD
make distclean 2>/dev/null 1>/dev/null

# REGENERATE BUILD FILES IF NECESSARY OR REQUESTED
if [[ ! -f "${BASEDIR}"/src/"${LIB_NAME}"/configure ]] || [[ ${RECONF_libtheora} -eq 1 ]]; then

  # WORKAROUND NOT TO RUN CONFIGURE AT THE END OF autogen.sh
  ${SED_INLINE} 's/$srcdir\/configure/#$srcdir\/configure/g' "${BASEDIR}"/src/"${LIB_NAME}"/autogen.sh || return 1

  ./autogen.sh || return 1
fi

./configure \
  --prefix="${LIB_INSTALL_PREFIX}" \
  --with-pic \
  --enable-static \
  --disable-shared \
  --disable-fast-install \
  --disable-examples \
  --disable-telemetry \
  --disable-sdltest \
  --disable-valgrind-testing \
  --host="${HOST}" || return 1

make -j$(get_cpu_count) || return 1

make install || return 1

# MANUALLY COPY PKG-CONFIG FILES
cp theoradec.pc "${INSTALL_PKG_CONFIG_DIR}" || return 1
cp theoraenc.pc "${INSTALL_PKG_CONFIG_DIR}" || return 1
cp theora.pc "${INSTALL_PKG_CONFIG_DIR}" || return 1
