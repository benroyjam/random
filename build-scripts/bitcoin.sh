#!/bin/sh

cd `dirname $0`/../bitcoin/ &&
git clean -xfd &&
git reset --hard &&
# cd src/ &&
# make -j2 -f makefile.unix USE_DBUS=1 USE_IPV6=0 USE_QRCODE=0 USE_UPNP=- DEBUGFLAGS= CFLAGS=-march=native CXXFLAGS=-march=native &&
# cd ../ &&
qmake-qt5 USE_DBUS=1 USE_IPV6=0 USE_QRCODE=0 USE_UPNP=- QMAKE_CFLAGS=-march=native QMAKE_CXXFLAGS=-march=native &&
make -j2
