SUMMARY = "A generic tool to merge nested data structures in python"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=5461efe2d19ce359c7d72d7be3c05e1c"

PYPI_PACKAGE = "deepmerge"

inherit pypi python_setuptools_build_meta native

do_configure:prepend() {
    cd ${S}
    sed -i 's/setuptools_scm>=5/setuptools_scm/g' pyproject.toml
}

export SETUPTOOLS_SCM_PRETEND_PV = "${PV}"

SRC_URI[sha256sum] = "53a489dc9449636e480a784359ae2aab3191748c920649551c8e378622f0eca4"

DEPENDS += " \
    python3-setuptools-native \
    python3-setuptools-scm-native \
    python3-wheel-native \
    python3-build-native \
    python3-installer-native \
"
