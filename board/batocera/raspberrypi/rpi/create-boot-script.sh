#!/bin/bash

# HOST_DIR = host dir
# BOARD_DIR = board specific dir
# BUILD_DIR = base dir/build
# BINARIES_DIR = images dir
# TARGET_DIR = target dir
# BATOCERA_BINARIES_DIR = batocera binaries sub directory

HOST_DIR=$1
BOARD_DIR=$2
BUILD_DIR=$3
BINARIES_DIR=$4
TARGET_DIR=$5
BATOCERA_BINARIES_DIR=$6

mkdir -p "${BATOCERA_BINARIES_DIR}/boot/rpi-firmware" || exit 1
mkdir -p "${BATOCERA_BINARIES_DIR}/boot/boot"         || exit 1

cp -f "${BINARIES_DIR}/"*.dtb      "${BATOCERA_BINARIES_DIR}/boot/" || exit 1
cp "${BOARD_DIR}/boot/config.txt"  "${BATOCERA_BINARIES_DIR}/boot/" || exit 1
cp "${BOARD_DIR}/boot/cmdline.txt" "${BATOCERA_BINARIES_DIR}/boot/" || exit 1

KERNEL_VERSION=$(grep -E "^BR2_LINUX_KERNEL_VERSION=" "${BR2_CONFIG}" | sed -e s+'^BR2_LINUX_KERNEL_VERSION="\(.*\)"$'+'\1'+)
"${BUILD_DIR}/linux-${KERNEL_VERSION}/scripts/mkknlimg" "${BINARIES_DIR}/zImage" "${BATOCERA_BINARIES_DIR}/boot/boot/linux" || exit 1
cp "${BINARIES_DIR}/initrd.gz"                          "${BATOCERA_BINARIES_DIR}/boot/boot"                 || exit 1
cp "${BINARIES_DIR}/rootfs.squashfs" 			"${BATOCERA_BINARIES_DIR}/boot/boot/batocera.update" || exit 1

exit 0