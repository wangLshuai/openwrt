#execute command "mkimage -A arm -O linux -T script -C none -a 0 -e 0 -d s805_autoscript.cmd s805_autoscript" after modify this file

setenv condev "console=ttyAML0,115200n8 loglevel=10 no_console_suspend consoleblank=0"
setenv bootargs_emmc "root=/dev/sda2 rootdelay=10 rw rowait ${condev} scsi_mod.pm=0 fsck.repair=yes net.ifnames=0 mac=${mac}"
setenv kernel_loadaddr "0x00208000"
setenv dtb_loadaddr "0x21800000"
setenv initrd_loadaddr "0x22000000"
setenv dtb_name "dtb"
#setenv boot_start bootm ${kernel_loadaddr} ${initrd_loadaddr} ${dtb_loadaddr}
setenv boot_start bootm ${kernel_loadaddr} - ${dtb_loadaddr}

#setenv serverip "192.168.0.99"
#setenv ipaddr "192.168.0.10"
#setenv netmask "255.255.255.0"
#tftp ${kernel_loadaddr} uImage
#tftp ${dtb_loadaddr} dtb
#setenv bootargs ${bootargs_emmc}
#run boot_start

if fatload usb 0 ${initrd_loadaddr} uInitrd; setenv bootargs ${bootargs_emmc}; then if fatload usb 0 ${kernel_loadaddr} uImage; then if fatload usb 0 ${dtb_loadaddr} ${dtb_name}; then run boot_start; else imgread dtb boot ${loadaddr} ${dtb_loadaddr}; run boot_start;fi;fi;fi;
