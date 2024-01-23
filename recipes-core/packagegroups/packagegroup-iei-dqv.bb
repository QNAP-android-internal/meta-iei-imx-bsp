# Copyright 2023 IEI

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

inherit allarch update-alternatives

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;;md5=801f80980d171dd6425610833a22dbe6"

IEI_DQV_JSON = "${@bb.utils.contains("MACHINE", "wafer-imx8mp", "B643_qc_config.json", "B664_qc_config.json", d)}"

SRC_URI += "\
     file://npu_files/coco_labels.txt \
     file://npu_files/imagenet_labels.txt \
     file://npu_files/key_point_labels.txt \
     file://npu_files/mobilenet_v1_1.0_224_quant.tflite \
     file://npu_files/posenet_resnet50_uint8_float32_quant.tflite \
     file://npu_files/ssd_mobilenet_v2_coco_quant_postprocess.tflite \
     file://npu_files/MLDemoLauncher.py \
     file://npu_files/nnclassification.py \
     file://npu_files/nnpose.py \
     file://npu_files/nnbrand.py \
     file://npu_files/nndetection.py \
     file://npu_files/utils.py \
     file://npu_files/downloads.txt \
     file://npu_files/LICENSE \
     file://npu_files/SW-Content-Register.txt \
     file://main.sh \
     file://configs/${IEI_DQV_JSON} \
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
     file://rs485.sh \
     file://buzzer_qc.sh \
     file://edp_qc.sh \
     file://lightbar_qc.sh \
     file://nor_qc.sh \
     file://touch_qc.sh \
"

do_install:append () {

    case ${DISTRO} in
        fsl-imx-xwayland)
            OS=Yocto
            ;;
        imx-desktop-xwayland)
            OS=Ubuntu
            ;;
    esac

    if [ ${OS} = "Ubuntu" ] ;then
        install -d ${D}/home/root/machine_learning/
        install -m 0644  ${WORKDIR}/npu_files/MLDemoLauncher.py ${D}/home/root/machine_learning/MLDemoLauncher.py
        install -m 0644  ${WORKDIR}/npu_files/nnbrand.py ${D}/home/root/machine_learning/nnbrand.py
        install -m 0644  ${WORKDIR}/npu_files/nnclassification.py ${D}/home/root/machine_learning/nnclassification.py
        install -m 0644  ${WORKDIR}/npu_files/nndetection.py ${D}/home/root/machine_learning/nndetection.py
        install -m 0644  ${WORKDIR}/npu_files/nnpose.py ${D}/home/root/machine_learning/nnpose.py
        install -m 0644  ${WORKDIR}/npu_files/utils.py ${D}/home/root/machine_learning/utils.py
        install -m 0644  ${WORKDIR}/npu_files/downloads.txt ${D}/home/root/machine_learning/downloads.txt
        install -m 0644  ${WORKDIR}/npu_files/LICENSE ${D}/home/root/machine_learning/LICENSE
        install -m 0644  ${WORKDIR}/npu_files/SW-Content-Register.txt ${D}/home/root/machine_learning/SW-Content-Register.txt
    fi

    install -d ${D}/home/root/.cache/demoexperience/
    install -m 0644  ${WORKDIR}/npu_files/coco_labels.txt ${D}/home/root/.cache/demoexperience/coco_labels.txt
    install -m 0644  ${WORKDIR}/npu_files/imagenet_labels.txt ${D}/home/root/.cache/demoexperience/1_1.0_224_labels.txt
    install -m 0644  ${WORKDIR}/npu_files/key_point_labels.txt ${D}/home/root/.cache/demoexperience/key_point_labels.txt
    install -m 0644  ${WORKDIR}/npu_files/mobilenet_v1_1.0_224_quant.tflite ${D}/home/root/.cache/demoexperience/mobilenet_v1_1.0_224_quant.tflite
    install -m 0644  ${WORKDIR}/npu_files/posenet_resnet50_uint8_float32_quant.tflite ${D}/home/root/.cache/demoexperience/posenet_resnet50_uint8_float32_quant.tflite
    install -m 0644  ${WORKDIR}/npu_files/ssd_mobilenet_v2_coco_quant_postprocess.tflite ${D}/home/root/.cache/demoexperience/mobilenet_ssd_v2_coco_quant_postprocess.tflite
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
    install -m 0755  ${WORKDIR}/configs/${IEI_DQV_JSON}  ${D}/qc/configs
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
    install -m 0755  ${WORKDIR}/rs485.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/buzzer_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/edp_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/lightbar_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/nor_qc.sh ${D}/qc/
    install -m 0755  ${WORKDIR}/touch_qc.sh ${D}/qc/
}

FILES:${PN} ="/qc/ \
/home/root/.cache/demoexperience/ \
/home/root/machine_learning/ \
"

DQV_TOOLS = "dialog jq stress-ng"
RDEPENDS:${PN}:append = "${DQV_TOOLS}"

