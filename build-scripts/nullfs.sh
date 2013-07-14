#!/bin/sh

cd `dirname $0`/../nullfs/ &&
make nul1fs &&
sudo cp ./nul1fs /usr/local/bin/
