SUMMARY = "Firmware for Lontium LT9611UXD DSI-to-HDMI bridge"
DESCRIPTION = "LT9611UXD firmware binary installed to /lib/firmware"
LICENSE = "CLOSED"

inherit allarch

SRC_URI = "git://10.20.70.37/sw3_linux_imx8_group/lkm/lt9611uxd.git;protocol=ssh;user=git;branch=master"
SRCREV = "83f4721727ecc7beba335d4d5d9e126ae11bb44b"

S = "${WORKDIR}/git"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install() {
    install -d ${D}${nonarch_base_libdir}/firmware
    install -m 0644 ${S}/firmware/LT9611UXD.bin ${D}${nonarch_base_libdir}/firmware/
}

FILES:${PN} = "${nonarch_base_libdir}/firmware/LT9611UXD.bin"
