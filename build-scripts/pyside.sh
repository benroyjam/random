#!/bin/sh

cd `dirname $0`/../pyside/
sudo env PYSIDE_BUILDSCRIPTS_USE_PYTHON3=yes CFLAGS=-march=native CXXFLAGS=-march=native ./build_and_install
sudo /sbin/ldconfig
