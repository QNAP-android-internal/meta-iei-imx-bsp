DESCRIPTION = "Android Bluetooth firmware loader"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;;md5=801f80980d171dd6425610833a22dbe6"
SRC_URI = "file://brcm-patchram-plus.c"

INSANE_SKIP:${PN} = "ldflags"
S = "${WORKDIR}"

do_compile() {
	${CC} brcm-patchram-plus.c -o brcm-patchram-plus
}

do_install() {
	install -d ${D}${bindir}
	install -m 0755 brcm-patchram-plus ${D}${bindir}
}
