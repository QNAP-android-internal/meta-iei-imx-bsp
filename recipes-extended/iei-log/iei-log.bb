DESCRIPTION = "release log"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;;md5=801f80980d171dd6425610833a22dbe6"
SRC_URI = "file://iei-release"
S = "${WORKDIR}"

do_install() {
        case ${MACHINE} in
                wafer-imx8mp)
                        SOC=643
                        ;;
                wafer-imx8mm)
                        SOC=664
                        ;;
        esac
        iei_meta_path=`echo ${BBPATH} | awk -F: '{for (i=1;i<=NF;i++)printf("%s\n", $i)}' |grep meta-iei-imx-bsp`
        cd ${iei_meta_path}
        version_number=`git tag |grep ${SOC} | tail -1`
        cd -

	install -d ${D}${sysconfdir}
	install -m 0755 ${WORKDIR}/iei-release ${D}${sysconfdir}/
	echo ${version_number} > ${D}${sysconfdir}/iei-release
}
