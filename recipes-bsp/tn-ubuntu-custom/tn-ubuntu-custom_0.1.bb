SUMMARY = "SystemD service to expand partition size for TechNexion products"
SECTION = "devel"

LICENSE = "GPL-3.0-only"
LIC_FILES_CHKSUM = "file://LICENSE;md5=783b7e40cdfb4a1344d15b1f7081af66"


SRC_URI += " \
    file://LICENSE \
    file://rc-local_ubuntu.service \
    file://rc-local_yocto.service \
    file://rc.local \
"

S = "${WORKDIR}"

inherit systemd allarch

USE_YOCTO = "${@bb.utils.contains("DISTRO_FEATURES", "wayland", "yes", "no", d)}"
USE_UBUNTU = "${@bb.utils.contains("DISTRO", "imx-desktop-xwayland", "yes", "no", d)}"

do_install () {
    install -d ${D}${sysconfdir}/systemd/system

    if [ "${USE_YOCTO}" = "yes" ]; then
        install -m 0644 ${S}/rc-local_yocto.service ${D}${sysconfdir}/systemd/system/rc-local.service
    elif  [ "${USE_UBUNTU}" = "yes" ]; then
        install -m 0644 ${S}/rc-local_ubuntu.service ${D}${sysconfdir}/systemd/system/rc-local.service
    fi

    install -d ${D}${sysconfdir}
    install -m 0755 ${S}/rc.local ${D}${sysconfdir}
}

FILES:${PN} = "${sysconfdir}/rc.local"

SYSTEMD_SERVICE:${PN} = "rc-local.service"
RDEPENDS:${PN} += "bash"
