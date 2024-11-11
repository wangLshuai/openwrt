# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2013-2014 OpenWrt.org

include $(TOPDIR)/rules.mk

ARCH:=arm
BOARD:=amlogic
BOARDNAME:=amlogic
FEATURES:=audio ext4 display fpu gpio pcie rtc usb usbgadget squashfs targz nand ubifs boot-part rootfs-part
SUBTARGETS:=s805

KERNEL_PATCHVER:=5.15

include $(INCLUDE_DIR)/target.mk

KERNELNAME:=zImage dtbs

DEFAULT_PACKAGES += -dropbear -dnsmasq -ppp
DEFAULT_PACKAGES += uboot-envtools mkf2fs e2fsprogs blkid lsblk bash vim-full xxd dnsmasq-full\
	coreutils coreutils-base64 coreutils-nohup lsof netcat iperf3 iftop bpftool-full sshfs tree procps-ng procps-ng-ps procps-ng-watch less htop sysstat tmux docker dockerd parted resize2fs losetup unzip ruby-yaml ruby\
	vim-runtime ntfs-3g strace libbz2 findutils liblz4 libunrar libzip-openssl libztd file  binutils diffutils fdisk exfat-mkfs fidutils libopenssl-legacy aria2 ARIA2_OPENSSL RIA2_NOXML ARIA2_BITTORRENT ariang luci-app-aria2 luci-i18n-aria2-zh-cn libpython3 python3-base python3-pip gcc\
	curl dns2socks dns2tcp ip-full libuci-lua luci-compat microsocks resolveip tcping ipt2socks libcap libcap-bin blockd dosfstools luci-app-opkg luci-i18n-opkg-zh-cn\
	xz-utils lz4 gzip bzip2 7z yt-dlp python3-aiohttp luci-app-qos luci-app-adblock libffmpeg-custom tailscale ntfs-3g-utils pandownload-fake-server lm-sensors lm-sensors-detect openssl-util docker-compose \
	openssh-sftp-server openssh-sftp-client openssh-server \
	uhttpd luci-base luci-theme-argon luci-i18n-base-zh-cn luci-mod-network luci-mod-system \
	luci-mod-dashboard luci-mod-admin-full luci-app-ttyd luci-i18n-ttyd-zh-cn\
	luci-app-openclash luci-app-homeproxy luci-i18n-openclash luci-app-firewall luci-i18n-firewall-zh-cn luci-i18n-homeproxy-zh-cn luci-app-passwall luci-i18n-passwall-zh-cn luci-compat

$(eval $(call BuildTarget))
