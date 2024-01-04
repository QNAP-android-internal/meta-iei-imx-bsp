DESCRIPTION = "hciattach-rtk for init BT in wifi5 module"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;;md5=801f80980d171dd6425610833a22dbe6"

INSANE_SKIP:${PN} = "ldflags"
S = "${WORKDIR}"

SRC_URI += "\
        file://hciattach.c \
        file://hciattach.h \
        file://hciattach_h4.c \
	file://hciattach_h4.h \
	file://hciattach_rtk.c \
	file://Makefile \
	file://rtb_fwc.c \
	file://rtb_fwc.h \
"

do_compile() {
	make
}
do_install() {
        install -d ${D}${bindir}
	install -m 0755 rtk_hciattach ${D}${bindir}/rtk-hciattach
}
