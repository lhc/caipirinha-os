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

echo ""

if [ -f conf/$APP/.config ];then
	echo ""
	echo "Found customized .config files"
else 
	echo ""
	echo "***Can't find conf/$APP/.config file exiting***"
	exit
fi

echo "Remove custom files from last build"
rm -rf $OPENWRT_PATH/files

echo "Copy general_files to OpenWrt"
cp -r conf/$APP/files $OPENWRT_PATH/files

echo ".config.$APP to OpenWrt/.config"
cp conf/$APP/.config $OPENWRT_PATH/.config

echo "Creates symbolic link for patches"
rm -f conf/patches
ln -s $APP/patches conf/patches

echo "***Entering build directory***"
cd $OPENWRT_PATH
quilt pop -a
echo "Applying patches"
quilt push -a
make defconfig
echo ""

echo ""
echo "Update build version and build date"
echo "Build: $BUILD"
echo "Build time: $BUILD_TIME"
echo ""

echo ""
if [ ! -z $SFLAG ];then
	echo "***Run make for single thread ***"
	make -s V=99
else
	echo "***Run make"
	make -j $(($(nproc)+1)) download world
fi