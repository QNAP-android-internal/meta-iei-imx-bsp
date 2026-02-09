FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
           file://zram.config \
"

do_install:append() {
    # Install systemd related configuration file
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -d ${D}${sysconfdir}/default
        install -m 0644 ${UNPACKDIR}/zram.config ${D}${sysconfdir}/default/zram
    fi
}
