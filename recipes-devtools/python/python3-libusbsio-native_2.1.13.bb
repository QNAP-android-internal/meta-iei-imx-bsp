SUMMARY = "Python wrapper around NXP LIBUSBSIO library"
HOMEPAGE = "https://pypi.org/project/libusbsio/"
LICENSE = "BSD-3-Clause"

LIC_FILES_CHKSUM = "file://license/BSD-3-clause.txt;md5=1076c1c40acc679330f3d60bfea1c23b"

PYPI_PACKAGE = "libusbsio"
SRC_URI[sha256sum] = "df1b9d4b2a9f5eadf0b0574e8017862b59d26343598f1f548664ea6d01975b25"

inherit pypi python_setuptools_build_meta native

INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_SYSROOT_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"

INSANE_SKIP:${PN}-native += "already-stripped dev-so arch libdir"

DEPENDS += "python3-libusb1-native"
