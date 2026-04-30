FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

UBOOT_SRC = "git://github.com/QNAP-android-internal/uboot-imx.git;protocol=https"
SRCBRANCH = "iei-imx_v2025.04_6.12.34-2.1.0-next"
SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"
SRCREV = "${AUTOREV}"

SRC_URI += "${@bb.utils.contains('DISTRO_FEATURES', 'secureboot', 'file://ahab.cfg', '', d)}"
