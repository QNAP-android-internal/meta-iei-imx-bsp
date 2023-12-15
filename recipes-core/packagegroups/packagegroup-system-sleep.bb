# Copyright 2023 IEI
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;;md5=801f80980d171dd6425610833a22dbe6"


SRC_URI += "\
	file://${THISDIR}/packagegroup-system-sleep/eth_resume.sh \
"

do_install() {
	case ${DISTRO} in
		fsl-imx-xwayland)
			OS=Yocto
			;;
		imx-desktop-xwayland)
			OS=Ubuntu
			;;
	esac
	if [ ${OS} = "Yocto" ] ;then
		install -d ${D}/lib/systemd/system-sleep/
		install -m 0755 ${THISDIR}/packagegroup-system-sleep/eth_resume.sh ${D}/lib/systemd/system-sleep/
		if [ ${MACHINE} = "iaso-imx8mm" ] ;then
			 install -m 0755 ${THISDIR}/packagegroup-system-sleep/g101ean024_power.sh ${D}/lib/systemd/system-sleep/
		fi
	fi
}
FILES:${PN} =" \
/lib/systemd/system-sleep/ \
"
