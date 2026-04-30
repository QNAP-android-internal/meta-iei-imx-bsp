SUMMARY = "X.690 (DER/BER) library for Python"
HOMEPAGE = "https://github.com/mmerickel/x690"
LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=32e321618dd99d9983a92a83fa679f55"

SRC_URI[sha256sum] = "d20068d3891c5710d6f25fc4db85d62b4b46bbcd07a4b994c5751ea777aa4fc0"

PYPI_PACKAGE = "x690"

inherit pypi python_setuptools_build_meta native

DEPENDS += " \
    python3-setuptools-native \
    python3-wheel-native \
    python3-build-native \
    python3-installer-native \
"
