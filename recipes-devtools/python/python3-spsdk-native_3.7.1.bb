SUMMARY = "NXP Secure Provisioning SDK (SPSDK)"
HOMEPAGE = "https://github.com/nxp-mcuxpresso/spsdk"
LICENSE = "BSD-3-Clause"

LIC_FILES_CHKSUM = "file://LICENSE;md5=863e3c0c79e2589ac9d16c3918e115d1"

PYPI_PACKAGE = "spsdk"
SRC_URI[sha256sum] = "20d820ae71e267e28a6cd1386ce6e4d0227ed1edc558a83d3421d2146bd4be57"

inherit pypi python_setuptools_build_meta native

do_configure:prepend() {
    sed -i 's/license\s*=\s*"BSD-3-Clause"/license = {text = "BSD-3-Clause"}/g' ${S}/pyproject.toml
    sed -i 's/setuptools>=77/setuptools>=69/g' pyproject.toml
}

export SETUPTOOLS_SCM_PRETEND_PV = "${PV}"

DEPENDS += " \
    python3-setuptools-native \
    python3-wheel-native \
    python3-build-native \
    python3-installer-native \
    python3-setuptools-scm-native \
    python3-pyproject-hooks-native \
    python3-pip-native \
    python3-click-native \
    python3-cryptography-native \
    python3-pyopenssl-native \
    python3-requests-native \
    python3-libusb1-native \
    python3-platformdirs-native \
    python3-colorama-native \
    python3-click-command-tree-native \
    python3-pyyaml-native \
    python3-hexdump-native \
    python3-prettytable-native \
    python3-filelock-native \
    python3-fastjsonschema-native \
    python3-deepmerge-native \
    python3-ruamel-yaml-native \
    python3-crcmod-native \
    python3-pyserial-native \
    python3-libusbsio-native \
    python3-libuuu-native \
    python3-sly-native \
    python3-x690-native \
    python3-t61codec-native \
    python3-bincopy-native \
    python3-humanfriendly-native \
    python3-argparse-addons-native \
    python3-pyelftools-native \
"
