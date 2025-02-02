# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="opentyrian"
PKG_VERSION="68beef64dcb1c183f86f8c7ba771d9085f7fce31"
PKG_SHA256="9963d411349cc28206c0e9b8f207f67e5fa283dd6a7d4c7df6abe6fd599050bc"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL2"
PKG_SITE="https://github.com/opentyrian/opentyrian"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain SDL2"
PKG_LONGDESC="An open-source port of the DOS shoot-em-up Tyrian."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  cd $PKG_BUILD
  rm -f tyrian21.zip
  rm -rf tyrian21
  wget -O tyrian21.zip https://www.camanis.net/tyrian/tyrian21.zip
  unzip $PKG_BUILD/tyrian21.zip

  mkdir -p $INSTALL/usr/local/bin
  cp opentyrian $INSTALL/usr/local/bin
  
  mkdir -p $INSTALL/usr/config/opentyrian
  cp -r $PKG_DIR/config/* $INSTALL/usr/config/opentyrian

  mkdir -p $INSTALL/usr/config/ports/opentyrian
  cp -rf $PKG_BUILD/tyrian21/* $INSTALL/usr/config/ports/opentyrian
}
