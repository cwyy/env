# author: Du, Changbin <changbin.du@gmail.com>

driver_src = `pwd`/dnw_for_linux/secbulk
dnw_src = dnw_for_linux/dnw

all: driver dnw

driver:
	make -C /lib/modules/`uname -r`/build M=$(driver_src) modules

dnw:
	make -C $(dnw_src)

install: all
	make -C $(dnw_src) install
	insmod $(driver_src)/secbulk.ko 
	cp dnw.rules /etc/udev/rules.d/
	depmod

clean:
	make -C $(dnw_src) clean
	make -C /lib/modules/`uname -r`/build M=$(driver_src) clean

