SUMMARY = "SLY (Sly Lex Yacc) is a Python implementation of lex and yacc"
HOMEPAGE = "https://github.com/dabeaz/sly"
LICENSE = "BSD-3-Clause"

LIC_FILES_CHKSUM = "file://LICENSE;md5=40c72247cf23e6d5397482dae055914a"

SRC_URI[sha256sum] = "251d42015e8507158aec2164f06035df4a82b0314ce6450f457d7125e7649024"

PYPI_PACKAGE = "sly"

inherit pypi python_setuptools_build_meta native

DEPENDS += " \
    python3-setuptools-native \
    python3-wheel-native \
    python3-build-native \
    python3-installer-native \
"
