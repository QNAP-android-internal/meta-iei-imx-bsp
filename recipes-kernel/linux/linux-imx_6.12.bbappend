FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

KERNEL_BRANCH = "iei-imx-6.12.34-2.1.0-next"
KERNEL_SRC = "git://github.com/QNAP-android-internal/kernel_imx.git;protocol=https"
SRC_URI = "${KERNEL_SRC};branch=${KERNEL_BRANCH}"
SRCREV = "${AUTOREV}"
