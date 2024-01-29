DESCRIPTION = "iei lightbar example"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;;md5=801f80980d171dd6425610833a22dbe6"

DEPENDS += " qtbase \
             qtdeclarative-native \
             qtquick3d"

RDEPENDS_${PN} += "qtwayland"

INSANE_SKIP:${PN} = "ldflags"
S = "${WORKDIR}/git"

SRC_URI = "git://github.com/QNAP-android-internal/IEI-AndroidLightBar.git;protocol=https;branch=iei-kirkstone_5.15.71-2.2.0-next"
SRCREV = "${AUTOREV}"
SCMVERSION = "n"

do_install:append() {

    install -d ${D}${datadir}/iei-lightbar
    install -m 0644 ${WORKDIR}/git/iei-lightbar_launcher.png ${D}${datadir}/iei-lightbar/
}

inherit qt6-cmake
