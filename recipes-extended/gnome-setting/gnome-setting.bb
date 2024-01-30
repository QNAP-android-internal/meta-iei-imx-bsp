FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

inherit allarch
LICENSE = "GPL-3.0-only"

LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-3.0-only;;md5=c79ff39f19dfec6d293b95dea7b07891"

SRC_URI = "file://gnome-setting.sh \
	file://gnome-shell-extensions-extra_20230205-2_all.bin \
"

S="${WORKDIR}"

do_install() {
    install -d ${D}/etc/profile.d/
    install -m 0664 ${WORKDIR}/gnome-setting.sh ${D}/etc/profile.d/gnome-setting.sh

    install -d ${D}/var/cache/PackageKit/downloads/
    install -m 0664 ${WORKDIR}/gnome-shell-extensions-extra_20230205-2_all.bin ${D}/var/cache/PackageKit/downloads/gnome-shell-extensions-extra_20230205-2_all.deb
}

FILES:${PN} = "\
     /etc/profile.d/ \
     /var/cache/PackageKit/downloads/ \
"
