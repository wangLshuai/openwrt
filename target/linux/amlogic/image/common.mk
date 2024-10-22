define Build/onecloud-combined-image-prepare
	rm -rf $@.boot
	rm -rf $@.boot.fat
	mkdir -p $@.boot
endef


FAT32_BLOCK_SIZE=1024
FAT32_BLOCKS=$(shell echo $$(($(CONFIG_TARGET_KERNEL_PARTSIZE)*1024*1024/$(FAT32_BLOCK_SIZE))))

define Build/onecloud-combined-image
	$(CP) $(IMAGE_KERNEL) $@.boot/uImage
	echo "***************BUILD_DIR $(BUILD_DIR)**************"
	echo "***************KERNEL_BUILD_DIR $(KERNEL_BUILD_DIR)***************"
	
	cp $(KERNEL_BUILD_DIR)/image-$(DEVICE_DTS).dtb $@.boot/dtb
	mkimage -A arm -O linux -T script -C none -a 0 -e 0 \
		-n '$(DEVICE_ID) OpenWrt bootscript' \
		-d s805_autoscript.cmd \
		$@.boot/s805_autoscript
	mkfs.fat -C $@.boot.fat $(FAT32_BLOCKS)
	mcopy -i $@.boot.fat $@.boot/* :: 
	./gen_aml_emmc_img.sh $@ $@.boot.fat $(IMAGE_ROOTFS) \
        $(CONFIG_TARGET_KERNEL_PARTSIZE) $(CONFIG_TARGET_ROOTFS_PARTSIZE)

endef


define Build/onecloud-usb-uboot
	$(Build/onecloud-combined-image-prepare)

	$(Build/onecloud-combined-image)
endef
