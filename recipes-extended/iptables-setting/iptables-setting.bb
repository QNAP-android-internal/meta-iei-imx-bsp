FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

inherit allarch
LICENSE = "GPL-3.0-only"

LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-3.0-only;;md5=c79ff39f19dfec6d293b95dea7b07891"

SRC_URI = "file://iptables-setting.sh \
"

S="${WORKDIR}"

do_install:append() {
    case ${DISTRO} in
        fsl-imx-xwayland)
            OS=Yocto
            ;;
        imx-desktop-xwayland)
            OS=Ubuntu
            ;;
    esac

    if [ ${OS} = "Ubuntu" ] ;then
	install -d ${D}/etc/profile.d/
	install -m 0664 ${WORKDIR}/iptables-setting.sh ${D}/etc/profile.d/iptables-setting.sh
    fi
}

FILES:${PN} = "\
     /etc/profile.d/ \
"

