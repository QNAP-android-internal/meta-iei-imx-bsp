DESCRIPTION = "fw_env.config for libubootenv"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;;md5=801f80980d171dd6425610833a22dbe6"

DEPENDS = "u-boot-fw-utils"

SRC_URI = "file://fw_env.config"
S = "${WORKDIR}"

do_install() {
	install -d ${D}${sysconfdir}
	install -m 0644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config
}
