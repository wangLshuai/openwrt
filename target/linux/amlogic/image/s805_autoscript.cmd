#execute command "mkimage -A arm -O linux -T script -C none -a 0 -e 0 -d s805_autoscript.cmd s805_autoscript" after modify this file

setenv condev "console=ttyAML0,115200n8 loglevel=10 no_console_suspend consoleblank=0"
setenv bootargs "rootdelay=10 rw rowait ${condev} scsi_mod.pm=0 fsck.repair=yes net.ifnames=0 mac=${mac}"
setenv usbroot "root=/dev/sda2"
setenv mmc1root "root=/dev/mmcblk1p2"
setenv mmc0root "root=/dev/mmcblk0p2"
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

echo "boot from usb"
if fatload usb 0 ${kernel_loadaddr} uImage; then if fatload usb 0 ${dtb_loadaddr} ${dtb_name}; then setenv bootargs "${usbroot} ${bootargs}"; run boot_start;fi;fi;
echo "fatload usb failed,try to boot from mmc1"
if fatload mmc 1 ${kernel_loadaddr} uImage; then if fatload mmc 1 ${dtb_loadaddr} ${dtb_name}; then setenv bootargs "${mmc1root} ${bootargs}"; run boot_start;fi;fi;
echo "fatload mmc 1 failed,try to boot from mm"
if fatload mmc 0 ${kernel_loadaddr} uImage; then if fatload mmc 0 ${dtb_loadaddr} ${dtb_name}; then setenv bootargs "${mmc0root} ${bootargs}"; run boot_start;fi;fi;