DEVICE_VARS += UBOOT

include common.mk

define Device/Default
  FILESYSTEMS := squashfs ext4
  KERNEL_INSTALL := 1
  KERNEL_SUFFIX := -uImage
  KERNEL_NAME := zImage
  KERNEL := kernel-bin | uImage none
  KERNEL_LOADADDR := 0x01080000
  IMAGES :=
endef

define Device/onecloud
  DEVICE_VENDOR := onethingcloud
  DEVICE_MODEL := oneclud
  DEVICE_DTS := meson8b-onecloud
  DEVICE_DTS_DIR := ../dts/
  KERNEL_LOADADDR := 0x00208000
  DEVICE_PACKAGES := kmod-sound-core \
	kmod-can kmod-can-flexcan kmod-can-raw kmod-leds-gpio \
	kmod-input-touchscreen-edt-ft5x06 kmod-usb-hid kmod-btsdio \
	kmod-brcmfmac brcmfmac-firmware-4339-sdio cypress-nvram-4339-sdio
  FILESYSTEMS := ext4
  IMAGES := combined.bin
  IMAGE/combined.bin := append-rootfs | pad-extra 128k | onecloud-usb-uboot
endef
TARGET_DEVICES += onecloud
