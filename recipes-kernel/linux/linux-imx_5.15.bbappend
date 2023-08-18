FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

KERNEL_BRANCH = "iei-imx-5.15.71-2.2.0-next"
KERNEL_SRC = "git://github.com/QNAP-android-internal/kernel_imx.git;protocol=https"
SRC_URI = "${KERNEL_SRC};branch=${KERNEL_BRANCH}"
SRCREV = "${AUTOREV}"
SCMVERSION = "n"

LOCALVERSION = ""

do_kernel_localversion_force() {

    # Force overwrite kernel localversion
    sed -i -e "/CONFIG_LOCALVERSION[ =]/d" ${B}/.config
    echo "CONFIG_LOCALVERSION=\"${LOCALVERSION}\"" >> ${B}/.config
    sed -i -e "/CONFIG_LOCALVERSION_AUTO[ =]/d" ${B}/.config
    echo "CONFIG_LOCALVERSION_AUTO=y" >> ${B}/.config
}

addtask kernel_localversion_force before do_configure after do_kernel_localversion
