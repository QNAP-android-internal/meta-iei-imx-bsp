SUMMARY = "Lontium LT9611UXD DRM bridge driver"
DESCRIPTION = "Out-of-tree kernel module for Lontium LT9611UXD DSI-to-HDMI bridge"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://Makefile;beginline=1;endline=1;md5=daad6f7f7a0a286391cd7773ccf79340"

SRC_URI = "git://10.20.70.37/sw3_linux_imx8_group/lkm/lt9611uxd.git;protocol=ssh;user=git;branch=master"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git"

inherit module

EXTRA_OEMAKE += "KDIR=${STAGING_KERNEL_DIR}"
