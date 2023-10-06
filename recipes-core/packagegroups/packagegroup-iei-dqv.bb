# Copyright 2023 IEI

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

inherit allarch update-alternatives

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;;md5=801f80980d171dd6425610833a22dbe6"

SRC_URI += "\
     file://main.sh \
     file://configs/B643_qc_config.json \
     file://log_qc.sh \
     file://log.txt \
     file://audio_qc.sh \
     file://bt_qc.sh \
     file://camera_qc.sh \
     file://cpu_qc.sh \
     file://emmc_qc.sh \
     file://eth_qc.sh \
     file://gpio_qc.sh \
     file://gpu_qc.sh \
     file://hdmi_qc.sh \
     file://mem_qc.sh \
     file://modem_qc.sh \
     file://otg_qc.sh \
     file://rtc_qc.sh \
     file://sd_qc.sh \
     file://uart_qc.sh \
     file://usb_qc.sh \
     file://video_qc.sh \
     file://wifi_qc.sh \
     file://burnin/bt_burnin.sh \
     file://burnin/camera_burnin.sh \
     file://burnin/cpu_burnin.sh \
     file://burnin/eth_burnin.sh \
     file://burnin/gpio_burnin.sh \
     file://burnin/gpu_burnin.sh \
     file://burnin/sd_burnin.sh \
     file://burnin/uart_burnin.sh \
     file://burnin/usb_burnin.sh \
     file://burnin/video_burnin.sh \
     file://burnin/wifi_burnin.sh \
"

do_install:append () {
    install -d ${D}/qc
    install -m 0755  ${WORKDIR}/main.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/log_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/log.txt ${D}/qc/
    install -m 0755  ${WORKDIR}/audio_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/bt_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/camera_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/cpu_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/emmc_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/eth_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/gpio_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/gpu_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/hdmi_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/mem_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/modem_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/otg_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/rtc_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/sd_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/uart_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/usb_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/video_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/wifi_qc.sh ${D}/qc/
    install -d ${D}/qc/configs/
    install -m 0755  ${WORKDIR}/configs/B643_qc_config.json  ${D}/qc/configs
    install -d ${D}/qc/burnin/
    install -m 0755  ${WORKDIR}/burnin/bt_burnin.sh ${D}/qc/burnin/
    install -m 0755  ${WORKDIR}/burnin/camera_burnin.sh ${D}/qc/burnin/
    install -m 0755  ${WORKDIR}/burnin/cpu_burnin.sh ${D}/qc/burnin/
    install -m 0755  ${WORKDIR}/burnin/eth_burnin.sh ${D}/qc/burnin/
    install -m 0755  ${WORKDIR}/burnin/gpio_burnin.sh ${D}/qc/burnin/
    install -m 0755  ${WORKDIR}/burnin/gpu_burnin.sh ${D}/qc/burnin/
    install -m 0755  ${WORKDIR}/burnin/sd_burnin.sh ${D}/qc/burnin/
    install -m 0755  ${WORKDIR}/burnin/uart_burnin.sh ${D}/qc/burnin/
    install -m 0755  ${WORKDIR}/burnin/usb_burnin.sh ${D}/qc/burnin/
    install -m 0755  ${WORKDIR}/burnin/video_burnin.sh ${D}/qc/burnin/
    install -m 0755  ${WORKDIR}/burnin/wifi_burnin.sh ${D}/qc/burnin/
}

FILES:${PN} ="/qc/"

DQV_TOOLS = "dialog jq stress-ng"
RDEPENDS:${PN}:append = "${DQV_TOOLS}"

