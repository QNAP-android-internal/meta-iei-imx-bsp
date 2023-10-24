DESCRIPTION = "release log"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;;md5=801f80980d171dd6425610833a22dbe6"
SRC_URI = "file://iei-release"
S = "${WORKDIR}"
do_install() {
	install -d ${D}${sysconfdir}
	install -m 0755 ${WORKDIR}/iei-release ${D}${sysconfdir}/
}

