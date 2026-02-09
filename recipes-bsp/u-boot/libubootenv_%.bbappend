FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

do_install:append() {
    install -m 0644 -D /dev/null ${D}${sysconfdir}/fw_env.config
    echo -n "/dev/${UBOOT_ENV_DEVICE} ${UBOOT_ENV_OFFSET} ${UBOOT_ENV_SIZE}" >> ${D}${sysconfdir}/fw_env.config
}
