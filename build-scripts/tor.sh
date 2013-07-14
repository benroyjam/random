#!/bin/sh

cd `dirname $0`/../tor/tor-0.2.3.25/ &&
make clean &&
./configure CFLAGS='-O2 -march=native' CXXFLAGS='-O2 -march=native' &&
make -j2 &&
sudo make install
