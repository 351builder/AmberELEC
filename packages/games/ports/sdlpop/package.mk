# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="sdlpop"
PKG_VERSION="211796b7a905028b6c1583bb6c78014bfaa385a0"
PKG_SHA256="1e3614bcd68aeb56435ac90b92a531fc406a4f9775c5ea07a0d5f9e5c9c8e435"
PKG_ARCH="any"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/NagyD/SDLPoP"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain SDL2 SDL2_image"
PKG_SHORTDESC="Prince of Persia SDL"
PKG_LONGDESC="An open-source port of Prince of Persia, based on the disassembly of the DOS version."
PKG_TOOLCHAIN="make"

pre_configure_target() {
  sed -i "s/start_fullscreen = false/start_fullscreen = true/" "$PKG_BUILD/SDLPoP.ini"
  sed -i "s/enable_info_screen = true;/enable_info_screen = false;/" "$PKG_BUILD/SDLPoP.ini"
}

pre_make_target() {
  CFLAGS+=" -I$(get_build_dir SDL2)/include -I$(get_build_dir SDL2_image) -D_REENTRANT"
}

make_target() {
  cd $PKG_BUILD/src/
  mkdir -p build
  cd build/
  cmake ..
  make CC=cc
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/config/distribution/configs/SDLPoP
  mkdir -p $INSTALL/usr/local/bin
  cp -r $PKG_BUILD/* $INSTALL/usr/config/distribution/configs/SDLPoP/
  mv "$INSTALL/usr/config/distribution/configs/SDLPoP/prince" "$INSTALL/usr/local/bin/"
  rm -rf $INSTALL/usr/config/distribution/configs/SDLPoP/src
  rm -rf $INSTALL/usr/config/distribution/configs/SDLPoP/.gitignore
  rm -rf $INSTALL/usr/config/distribution/configs/SDLPoP/.editorconfig
}
