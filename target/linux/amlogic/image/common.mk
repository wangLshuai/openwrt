define Build/onecloud-combined-image-prepare
	rm -rf $@.boot
	rm -rf $@.boot.fat
	mkdir -p $@.boot
endef

define Build/onecloud-combined-image-clean
	rm -rf $@.boot $@.fs
endef

FAT32_BLOCK_SIZE=1024
FAT32_BLOCKS=$(shell echo $$(($(CONFIG_TARGET_KERNEL_PARTSIZE)*1024*1024/$(FAT32_BLOCK_SIZE))))

define Build/onecloud-combined-image
	$(CP) $(IMAGE_KERNEL) $@.boot/uImage

	dtc -I dts ../dts/$(DEVICE_DTS).dts -o $@.boot/dtb

	mkimage -A arm -O linux -T script -C none -a 0 -e 0 \
		-n '$(DEVICE_ID) OpenWrt bootscript' \
		-d s805_autoscript.cmd \
		$@.boot/s805_autoscript
	cp $@ $@.fs
	mkfs.fat -C $@.boot.fat $(FAT32_BLOCKS)

	$(foreach file,$(wildcard $@.boot/*),\
		mcopy -i $@.boot.fat $(file) :: ;)
	./gen_aml_emmc_img.sh $@ $@.boot.fat $(IMAGE_ROOTFS) \
        $(CONFIG_TARGET_KERNEL_PARTSIZE) $(CONFIG_TARGET_ROOTFS_PARTSIZE)

endef

define Build/onecloud-sdcard
	$(Build/onecloud-combined-image-prepare)

	if [ -f $(STAGING_DIR_IMAGE)/$(UBOOT)-u-boot.img ]; then \
		$(CP) $(STAGING_DIR_IMAGE)/$(UBOOT)-u-boot.img \
		$@.boot/u-boot.img; \
	fi

	if [ -f $(STAGING_DIR_IMAGE)/$(UBOOT)-u-boot-dtb.img ]; then \
		$(CP) $(STAGING_DIR_IMAGE)/$(UBOOT)-u-boot-dtb.img \
		$@.boot/u-boot-dtb.img; \
	fi

	$(Build/onecloud-combined-image)
	dd if=$(STAGING_DIR_IMAGE)/$(UBOOT)-SPL of=$@ bs=1024 seek=1 conv=notrunc

	$(Build/onecloud-combined-image-clean)
endef

define Build/onecloud-usb-uboot
	$(Build/onecloud-combined-image-prepare)

	$(Build/onecloud-combined-image)

#	$(Build/onecloud-combined-image-clean)
endef
