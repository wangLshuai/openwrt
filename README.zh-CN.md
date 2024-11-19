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
echo "CONFIG_TARGET_amlogic=y" >> .config
echo "CONFIG_TARGET_amlogic_s805=y" >> .config
echo "CONFIG_TARGET_ROOTFS_PARTSIZE=700" >> .config
echo "CONFIG_TARGET_ROOTFS_EXT4FS=y" >> .config
echo "CONFIG_LUCI_LANG_zh_Hans=y" >> .config
echo "CONFIG_TARGET_ROOTFS_PERSIST_VAR=y" >> .config
echo "CONFIG_HTOP_LMSENSORS=y" >> .config


echo "CONFIG_FFMPEG_CUSTOM_GPL=y
CONFIG_FFMPEG_CUSTOM_GPLV3=y
CONFIG_FFMPEG_CUSTOM_NONFREE=y
CONFIG_FFMPEG_CUSTOM_PATENTED=y
CONFIG_FFMPEG_CUSTOM_LARGE=y
CONFIG_FFMPEG_CUSTOM_MINIDLNA_SUPPORT=y
CONFIG_FFMPEG_CUSTOM_AUDIO_DEC_SUPPORT=y
CONFIG_FFMPEG_CUSTOM_PROGRAMS=y
CONFIG_FFMPEG_CUSTOM_SELECT_libfdk-aac=y
CONFIG_FFMPEG_CUSTOM_SELECT_libmp3lame=y
CONFIG_FFMPEG_CUSTOM_SELECT_libopus=y
CONFIG_FFMPEG_CUSTOM_SELECT_libshine=y
CONFIG_FFMPEG_CUSTOM_ENCODER_ac3=y
CONFIG_FFMPEG_CUSTOM_ENCODER_jpegls=y
CONFIG_FFMPEG_CUSTOM_ENCODER_mpeg1video=y
CONFIG_FFMPEG_CUSTOM_ENCODER_mpeg2video=y
CONFIG_FFMPEG_CUSTOM_ENCODER_mpeg4=y
CONFIG_FFMPEG_CUSTOM_ENCODER_pcm_s16be=y
CONFIG_FFMPEG_CUSTOM_ENCODER_pcm_s16le=y
CONFIG_FFMPEG_CUSTOM_ENCODER_png=y
CONFIG_FFMPEG_CUSTOM_ENCODER_vorbis=y
CONFIG_FFMPEG_CUSTOM_ENCODER_zlib=y
CONFIG_FFMPEG_CUSTOM_DECODER_aac=y
CONFIG_FFMPEG_CUSTOM_SELECT_adpcm=y
CONFIG_FFMPEG_CUSTOM_DECODER_ac3=y
CONFIG_FFMPEG_CUSTOM_DECODER_alac=y
CONFIG_FFMPEG_CUSTOM_DECODER_amrnb=y
CONFIG_FFMPEG_CUSTOM_DECODER_amrwb=y
CONFIG_FFMPEG_CUSTOM_DECODER_ape=y
CONFIG_FFMPEG_CUSTOM_DECODER_atrac3=y
CONFIG_FFMPEG_CUSTOM_DECODER_flac=y
CONFIG_FFMPEG_CUSTOM_DECODER_gif=y
CONFIG_FFMPEG_CUSTOM_DECODER_h264=y
CONFIG_FFMPEG_CUSTOM_DECODER_hevc=y
CONFIG_FFMPEG_CUSTOM_DECODER_jpegls=y
CONFIG_FFMPEG_CUSTOM_DECODER_mp2=y
CONFIG_FFMPEG_CUSTOM_DECODER_mp3=y
CONFIG_FFMPEG_CUSTOM_DECODER_mpegvideo=y
CONFIG_FFMPEG_CUSTOM_DECODER_mpeg1video=y
CONFIG_FFMPEG_CUSTOM_DECODER_mpeg2video=y
CONFIG_FFMPEG_CUSTOM_DECODER_mpeg4=y
CONFIG_FFMPEG_CUSTOM_DECODER_mpc7=y
CONFIG_FFMPEG_CUSTOM_DECODER_mpc8=y
CONFIG_FFMPEG_CUSTOM_DECODER_opus=y
CONFIG_FFMPEG_CUSTOM_DECODER_pcm_s16be=y
CONFIG_FFMPEG_CUSTOM_DECODER_pcm_s16le=y
CONFIG_FFMPEG_CUSTOM_DECODER_png=y
CONFIG_FFMPEG_CUSTOM_DECODER_vc1=y
CONFIG_FFMPEG_CUSTOM_DECODER_vorbis=y
CONFIG_FFMPEG_CUSTOM_DECODER_wavpack=y
CONFIG_FFMPEG_CUSTOM_DECODER_wmav1=y
CONFIG_FFMPEG_CUSTOM_DECODER_wmav2=y
CONFIG_FFMPEG_CUSTOM_DECODER_zlib=y
CONFIG_FFMPEG_CUSTOM_MUXER_ac3=y
CONFIG_FFMPEG_CUSTOM_MUXER_avi=y
CONFIG_FFMPEG_CUSTOM_MUXER_h264=y
CONFIG_FFMPEG_CUSTOM_MUXER_hevc=y
CONFIG_FFMPEG_CUSTOM_MUXER_mp3=y
CONFIG_FFMPEG_CUSTOM_MUXER_mp4=y
CONFIG_FFMPEG_CUSTOM_MUXER_mpeg1video=y
CONFIG_FFMPEG_CUSTOM_MUXER_mpeg2video=y
CONFIG_FFMPEG_CUSTOM_MUXER_mpegts=y
CONFIG_FFMPEG_CUSTOM_MUXER_ogg=y
CONFIG_FFMPEG_CUSTOM_MUXER_rtp=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_aac=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_avi=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_ac3=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_amr=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_ape=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_flac=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_h264=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_hevc=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_matroska=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_mov=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_mp3=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_mpegvideo=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_mpegps=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_mpegts=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_mpc=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_mpc8=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_ogg=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_rm=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_rtsp=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_sdp=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_rtp=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_vc1=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_wav=y
CONFIG_FFMPEG_CUSTOM_DEMUXER_wv=y
CONFIG_FFMPEG_CUSTOM_PARSER_aac=y
CONFIG_FFMPEG_CUSTOM_PARSER_flac=y
CONFIG_FFMPEG_CUSTOM_PARSER_h264=y
CONFIG_FFMPEG_CUSTOM_PARSER_hevc=y
CONFIG_FFMPEG_CUSTOM_PARSER_mpegaudio=y
CONFIG_FFMPEG_CUSTOM_PARSER_mpegvideo=y
CONFIG_FFMPEG_CUSTOM_PARSER_mpeg4video=y
CONFIG_FFMPEG_CUSTOM_PARSER_opus=y
CONFIG_FFMPEG_CUSTOM_PARSER_vc1=y
CONFIG_FFMPEG_CUSTOM_PROTOCOL_file=y
CONFIG_FFMPEG_CUSTOM_PROTOCOL_http=y
CONFIG_FFMPEG_CUSTOM_PROTOCOL_icecast=y
CONFIG_FFMPEG_CUSTOM_PROTOCOL_pipe=y
CONFIG_FFMPEG_CUSTOM_PROTOCOL_rtp=y
CONFIG_FFMPEG_CUSTOM_PROTOCOL_tcp=y
CONFIG_FFMPEG_CUSTOM_PROTOCOL_udp=y
" >> .config

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

