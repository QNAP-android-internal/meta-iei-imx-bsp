SUMMARY = "Perfectly natural hex dump for Python"
HOMEPAGE = "https://github.com/ignatev/hexdump"
LICENSE = "PD"

LIC_FILES_CHKSUM = "file://README.txt;md5=c6f4c4a89d18906956c6b1431d71c2bd"

SRC_URI[sha256sum] = "d781a43b0c16ace3f9366aade73e8ad3a7bd5137d58f0b45ab2d3f54876f20db"

PYPI_PACKAGE = "hexdump"
PYPI_PACKAGE_EXT = "zip"

inherit pypi setuptools3 native

SRC_URI = "${PYPI_SRC_URI};subdir=hexdump-${PV}"

S = "${WORKDIR}/hexdump-${PV}"

DEPENDS += "unzip-native"
