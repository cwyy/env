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
TOPDIR=`pwd`
USRMODUL="/usr/local/module"
cd dnw_for_linux/secbulk
CURDIR=`pwd`
echo "Entering $CURDIR"
#install module secbulk
make -C /lib/modules/`uname -r`/build M=`pwd` modules
if [ -e 'secbulk.ko' ]
then
	echo "secbulk.ko exist!"
	insmod secbulk.ko
	#when computer on,load it automatically"
	mkdir -p $USRMODUL
	cp secbulk.ko $USRMODUL 
	make clean
	echo "insmod $USRMODUL/secbulk.ko" >> /etc/init.d/rc.local
else
	echo "secbulk.ko not exist,compile error"
	exit 1
fi
CURDIR=$TOPDIR
cd $CURDIR/dnw_for_linux/dnw
CURDIR=`pwd`
echo "Entering $CURDIR"
#compile dnw
gcc -o dnw dnw.c
if [ -e 'dnw' ]
then
	echo "dnw exist!"
	#cp dnw to file /usr/local/bin
	cp dnw /usr/local/bin
	make clean
else
	echo "dnw compile error!"
fi

