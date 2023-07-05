#!/usr/bin/env bash
#Set up build environment for Dragino v2. Only need to run once on first compile. 

OPENWRT_PATH=openwrt

while getopts 'p:v:sh' OPTION
do
	case $OPTION in
	p)	OPENWRT_PATH="$OPTARG"
		;;
	h|?)	printf "Set Up OpenWrt environment for Caipirinha-OS\n\n"
		printf "Usage: %s [-p <openwrt_source_path>]\n" $(basename $0) >&2
		printf "	-p: set up build path, default path = openwrt\n"
		printf "\n"
		exit 1
		;;
	esac
done

shift $(($OPTIND - 1))

REPO_PATH=$(pwd)

cd $REPO_PATH
echo "*** Backup original feeds files if they exist"
[ -f $OPENWRT_PATH/feeds.conf.default ] &&  mv $OPENWRT_PATH/feeds.conf.default $OPENWRT_PATH/feeds.conf.default.bak

echo "*** Copy feeds used in Caipirinha-OS"
cp feeds.caipirinha $OPENWRT_PATH/feeds.conf.default

echo " "
echo "*** Update the feeds (See ./feeds-update.log)"
sleep 2
$OPENWRT_PATH/scripts/feeds update -a
sleep 2
echo " "

echo "*** Install OpenWrt extra packages"
sleep 2
$OPENWRT_PATH/scripts/feeds install -a
echo " "

echo "End of script"
