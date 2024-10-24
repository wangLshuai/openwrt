为玩客云适配openwrt,使用了immotalwrt的feed包

未修改任何upstream的内容,保持干净。

git clone https://github.com/wangLshuai/openwrt.git

cd openwrt

下载feeds的所有的包，保存在feeds目录下，每个package是一个Makefile,包含了真正的软件的链接和构建方式。
./script/feeds update -a

把所有的feed package都建立一个在package目录下的软连接
./scripts/feeds install -a


设置target,subtarget,rootfs size.rootfs文件系统是ext4格式,其它的为默认配置
echo "CONFIG_TARGET_amlogic=y" >> .config
echo "CONFIG_TARGET_amlogic_s805=y" >> .config
echo "CONFIG_TARGET_ROOTFS_PARTSIZE=300" >> .config
echo "CONFIG_TARGET_ROOTFS_EXT4FS=y" >> .config
make defconfig 

遍历所有的配置选择的包，下载包的源码
make downlaod

解压并打补丁
make prepare

make使用cpu数目个线程去构建
make -j`nproc` 


多线程构建容易出错
 make[3] -C feeds/luci/applications/luci-app-openclash compile
    ERROR: package/feeds/luci/lucihttp failed to build.

单独编译报错的包并输出详细log，通常是下载的问题
make package/lucihttp/compile V=sc

make package/ppp/compile CONFIG_PACKAGE_ppp=m -j4

make package/luci/compile CONFIG_PACKAGE_luci-mod-system=m


文件bin/targets/amlogic/s805/openwrt-amlogic-s805-onecloud-ext4-combined.bin.gz是镜像，
gzip -d openwrt-amlogic-s805-onecloud-ext4-combined.bin.gz 后得到openwrt-amlogic-s805-onecloud-ext4-combined.bin，用dd或者usbImager烧录到u盘中，
可以去修改U盘根文件系统中/etc/config/network的网络设备的ip和网段

config interface 'lan'
        option device 'br-lan'
        option proto 'static'
        option ipaddr '192.168.0.98'
        option netmask '255.255.255.0'
        option gateway '192.168.0.1'
        list dns '192.168.0.1'


需要先烧录能够从u盘启动的玩客云uboot
插入u盘到玩客云接近以太网插口的那个usb,上电启动。
uboot找到fat32 u盘分区，运行s805_autoscript 去加载内核和dtb,最后跳转到内核。


