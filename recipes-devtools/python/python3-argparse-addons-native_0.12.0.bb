SUMMARY = "Additional argparse types and actions"
HOMEPAGE = "https://github.com/eerimoq/argparse_addons"
LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://LICENSE;md5=515e9da3e929c7b40dd13458363110a7"

SRC_URI[sha256sum] = "6322a0dcd706887e76308d23136d5b86da0eab75a282dc6496701d1210b460af"

PYPI_PACKAGE = "argparse_addons"

inherit pypi python_setuptools_build_meta native

DEPENDS += " \
    python3-setuptools-native \
    python3-wheel-native \
    python3-build-native \
    python3-installer-native \
"
