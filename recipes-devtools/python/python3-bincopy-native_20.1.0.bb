SUMMARY = "Mangling of various file formats that conveys binary information"
HOMEPAGE = "https://github.com/eerimoq/bincopy"
LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://LICENSE;md5=d9aa4ec07de78abae21c490c9ffe61bd"

SRC_URI[sha256sum] = "d8a4e8cb82edafbbe367415337d1926c7d8c455617e43bd4b145653772b9b965"

PYPI_PACKAGE = "bincopy"


inherit pypi python_setuptools_build_meta native

DEPENDS += " \
    python3-setuptools-native \
    python3-wheel-native \
    python3-build-native \
    python3-installer-native \
"
