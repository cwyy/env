#!/bin/bash
#echo "install libusb-dev"
#apt-get install libusb-dev
if [ $UID == "0" ]
then
	echo "root user!"
else
	echo "**please use root user**"
	exit 1
fi
#make
make
if [ -e "dnw_for_linux/secbulk/secbulk.ko" ]
then
	make install
else
	echo "**compile error!**"
	exit 1
fi
#make clean
make clean

