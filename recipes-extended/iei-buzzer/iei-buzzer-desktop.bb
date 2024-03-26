inherit allarch
LICENSE = "GPL-3.0-only"

LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-3.0-only;;md5=c79ff39f19dfec6d293b95dea7b07891"

SRC_URI = "file://iei-buzzer.desktop "

S="${WORKDIR}"

do_install() {
case ${DISTRO} in
        fsl-imx-xwayland)
                OS=Yocto
                ;;
        imx-desktop-xwayland)
                OS=Ubuntu
                ;;
    esac
    if [ ${OS} = "Ubuntu" ] ;then

    install -d ${D}/usr/share/applications/
    install -m 0664 ${WORKDIR}/iei-buzzer.desktop ${D}/usr/share/applications/iei-buzzer.desktop
    fi

}

FILES:${PN} = " /usr/share/applications/ "

