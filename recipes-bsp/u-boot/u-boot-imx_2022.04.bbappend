FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

UBOOT_SRC = "git://github.com/QNAP-android-internal/uboot-imx.git;protocol=https"
SRCBRANCH = "iei-imx_v2022.04_5.15.71_2.2.0-next"
SRC_URI = "${UBOOT_SRC};branch=${SRCBRANCH}"
SRCREV = "${AUTOREV}"

do_deploy:append () {
	install -d ${DEPLOYDIR}
}

do_deploy:append:mx8m-nxp-bsp() {
    # Deploy u-boot-nodtb.bin and fsl-imx8mq-XX.dtb, to be packaged in boot binary by imx-boot
    if [ -n "${UBOOT_CONFIG}" ]
    then
        for config in ${UBOOT_MACHINE}; do
            i=$(expr $i + 1);
            for type in ${UBOOT_CONFIG}; do
                j=$(expr $j + 1);
                if [ $j -eq $i ]
                then
                    install -d ${DEPLOYDIR}/${BOOT_TOOLS}
                    for DTB in ${UBOOT_DTB_NAME}; do
                        install -m 0777 ${B}/${config}/arch/arm/dts/${DTB}  ${DEPLOYDIR}/${BOOT_TOOLS}
                    done
                    install -m 0777 ${B}/${config}/u-boot-nodtb.bin  ${DEPLOYDIR}/${BOOT_TOOLS}/u-boot-nodtb.bin-${MACHINE}-${UBOOT_CONFIG}
                fi
            done
            unset  j
        done
        unset  i
    fi

}

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(mx8-generic-bsp)"
