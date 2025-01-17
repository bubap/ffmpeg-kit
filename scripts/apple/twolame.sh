#!/bin/bash

# UPDATE BUILD FLAGS
export SNDFILE_CFLAGS="$(pkg-config --dont-define-prefix --cflags sndfile)"
export SNDFILE_LIBS="$(pkg-config --dont-define-prefix --libs --static sndfile)"

# ALWAYS CLEAN THE PREVIOUS BUILD
make distclean 2>/dev/null 1>/dev/null

# REGENERATE BUILD FILES IF NECESSARY OR REQUESTED
if [[ ! -f "${BASEDIR}"/src/"${LIB_NAME}"/configure ]] || [[ ${RECONF_twolame} -eq 1 ]]; then
  NOCONFIGURE=1 ./autogen.sh || return 1
fi

./configure \
  --prefix="${LIB_INSTALL_PREFIX}" \
  --with-pic \
  --with-sysroot="${SDK_PATH}" \
  --enable-static \
  --disable-shared \
  --disable-fast-install \
  --host="${HOST}" || return 1

# WORKAROUND TO DISABLE BUILDING OF DOCBOOK - BUILD SCRIPTS DO NOT GENERATE A TARGET FOR IT
${SED_INLINE} 's/dist_man_MANS = .*/dist_man_MANS =/g' "${BASEDIR}"/src/"${LIB_NAME}"/doc/Makefile || return 1

make -j$(get_cpu_count) || return 1

make install || return 1

# MANUALLY COPY PKG-CONFIG FILES
cp ./*.pc "${INSTALL_PKG_CONFIG_DIR}" || return 1
