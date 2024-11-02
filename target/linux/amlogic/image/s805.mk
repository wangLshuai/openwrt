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
  DEVICE_PACKAGES := kmod-sound-core kmod-vfat-fs\
	kmod-leds-gpio kmod-usb-hid kmod-fs-vfat kmod-fs-autofs4
  FILESYSTEMS := ext4
  IMAGES := combined.bin
  IMAGE/combined.bin := onecloud-usb-uboot
endef
TARGET_DEVICES += onecloud
