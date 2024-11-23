为玩客云OneCloud适配openwrt,使用了immotalwrt的feed包

![CI Status](https://github.com/wangLshuai/openwrt/actions/workflows/build.yml/badge.svg)

未修改任何upstream的内容,保持干净。

## build
[安装构建环境](https://openwrt.org/docs/guide-developer/toolchain/install-buildsystem)

```shell
git clone https://github.com/wangLshuai/openwrt.git

cd openwrt
```
下载feeds的所有的包，保存在feeds目录下，每个package是一个Makefile,包含了真正的软件的链接和构建方式。
```shell
./script/feeds update -a
```
把所有的feed package都建立一个在package目录下的软连接
```shell
./scripts/feeds install -a
```

设置target,subtarget,rootfs size。rootfs文件系统是ext4格式,其它的为默认配置
设置luci默认使能i18n-zh-cn，设置/var目录不是/tmp的软链接，设置htop使能sensors。设置ffmpeg enable software codec/decode
```shell
cp onecloud.config .config
make defconfig 
```

遍历所有的配置选择的包，下载包的源码
```shell
make download
```
make使用cpu数目个线程去构建builder工具
```shell
make prepare -j`nproc`
```

make使用cpu数目个线程去构建
```shell
make -j`nproc` 
```


多线程构建容易出错

 make[3] -C feeds/luci/applications/luci-app-openclash compile
    ERROR: package/feeds/luci/lucihttp failed to build.

单独编译报错的包并输出详细log，通常是下载的问题
```shell
make package/lucihttp/compile V=sc
```

或者覆盖掉.config的CONFIG_PACKAGE_xxx选项，编译成独立的包，m是独立的ipk包，y是安装到镜像中去
```shell
make package/ppp/compile CONFIG_PACKAGE_ppp=m -j4

make package/luci/compile CONFIG_PACKAGE_luci-mod-system=m
```

文件bin/targets/amlogic/s805/openwrt-amlogic-s805-onecloud-ext4-combined.bin.gz是镜像，
```shell
gzip -d openwrt-amlogic-s805-onecloud-ext4-combined.bin.gz 
```
后得到openwrt-amlogic-s805-onecloud-ext4-combined.bin，用dd或者usbImager烧录到u盘中，
```shell
sudo dd if=openwrt-amlogic-s805-onecloud-ext4-combined.bin of=/dev/sda bs=1M
```

可以去修改U盘根文件系统中/etc/config/network的网络设备的ip和网段,gateway
```
config interface 'lan'
        option device 'br-lan'
        option proto 'static'
        option ipaddr '192.168.0.98'
        option netmask '255.255.255.0'
        option gateway '192.168.0.1'
        list dns '192.168.0.1'

```
需要先烧录能够从u盘启动的玩客云uboot
插入u盘到玩客云接近以太网插口的那个usb,上电启动。
uboot找到fat32 u盘分区，运行s805_autoscript 去加载内核和dtb,最后跳转到内核。
第一次内核启动时会执行/etc/uci-default/70-rootpt-resize脚本，扩大sda2分区，重启，然后启动运行/etc/uci-defaults/80-rootfs-resize脚本，扩大sda2 ext4文件系统。然后重启。
上电蓝灯亮，dts中被设置为红灯心跳，内核初始化时红灯闪烁。进入根文件系统后，led管理程序配置led,默认是蓝灯常亮。红绿关闭。

使用浏览器登陆web管理界面,首次登陆需要设置password。

