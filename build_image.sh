#!/usr/bin/env bash
#Build Arduino Yun Image for Dragino2. MS14, HE. 

SFLAG=
AFLAG=
BFLAG=

APP="caipirinha"
IMAGE_SUFFIX=
BUILD_TIME=`date +%s`

REPO_PATH=$(pwd)
VERSION="22.03"
OPENWRT_PATH="openwrt"

while getopts 'a:p:sh' OPTION
do
	case $OPTION in
	a)	
		AFLAG=1
		APP="$OPTARG"
		;;
	p)	OPENWRT_PATH="$OPTARG"
		;;

	s)	SFLAG=1
		;;

	h|?)	printf "Build Image for Caipirinha\n\n"
		printf "Usage: %s [-p <openwrt_source_path>] [-a <application>] [-s] \n" $(basename $0) >&2
		printf "	-a: application file to build\n"
		printf "	-s: build in singe thread\n"
		printf "\n"
		exit 1
		;;
	esac
done

shift $(($OPTIND - 1))


BUILD=$APP-$VERSION

BUILD_TIME="`date`"

ARCH="bcm27xx"

file_prefix="caipirinha-os-bcm27xx-bcm2710-rpi-3"
target_path="bin/targets/bcm27xx/bcm2710"

echo ""

echo "Remove custom files from last build"

rm -rf $OPENWRT_PATH/files

echo "***Copy general_files to OpenWrt***"
cp -r general_files $OPENWRT_PATH/files

echo "***.config.$APP to OpenWrt/.config***"
cp .config.$APP $OPENWRT_PATH/.config

cd $REPO_PATH

if [ -f .config.$APP ];then
	echo ""
	echo "***Find customized .config files***"
	echo "Replace default .config file with .config.$APP"
	echo ""
	cp .config.$APP $OPENWRT_PATH/.config
else 
	echo ""
	echo "***Can't find .config.$APP file***"
	echo "Use default .config.$DEFAULT_APP"
	echo ""
fi

echo ""

echo "***Entering build directory***"

cd $OPENWRT_PATH

make defconfig

#make sure fresh the luci-app on each build
#rm -rf build_dir/target-mips_24kc_musl/luci-app-*

echo ""

echo ""
echo "***Update build version and build date***"
echo "Build: $BUILD"
echo "Build time: $BUILD_TIME"
echo ""


[ -f ./$target_path/$file_prefix-squashfs-sysupgrade.img.gz ] && rm -rf ./$target_path/??*

echo ""
if [ ! -z $SFLAG ];then
	echo "***Run make for single thread ***"
	make -s V=99
else
	echo "***Run make"
	make -j $(($(nproc)+1)) download world
fi

