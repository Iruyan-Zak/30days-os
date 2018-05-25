img:
	make -r helloos.img

run: img
	qemu-system-x86_64 -fda helloos.img

ipl.bin: ipl.nas
	../z_tools/nask ipl.nas ipl.bin ipl.lst

helloos.img: ipl.bin
	../z_tools/edimg imgin:../z_tools/fdimg0at.tek \
		wbinimg src:ipl.bin len:512 from:0 to:0 imgout:helloos.img
