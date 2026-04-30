SUMMARY = "NXP Secure Provisioning SDK (SPSDK)"
HOMEPAGE = "https://github.com/nxp-mcuxpresso/spsdk"
LICENSE = "BSD-3-Clause"

LIC_FILES_CHKSUM = "file://LICENSE;md5=863e3c0c79e2589ac9d16c3918e115d1"

PYPI_PACKAGE = "spsdk"
SRC_URI[sha256sum] = "4309d1b3cc94dfa0bf53e53b1da0b6de327bc0ffa4e6e7920df435e897bdd4db"

inherit pypi python_setuptools_build_meta native

do_configure:prepend() {
    cd ${S}

    if [ -f pyproject.toml ]; then
        sed -i 's/setuptools>=[0-9]*/setuptools/g' pyproject.toml

        sed -i 's/license = "BSD-3-Clause"/license = {text = "BSD-3-Clause"}/g' pyproject.toml

        sed -i 's/setuptools[-_]scm[<>=]*[0-9.]*/setuptools-scm/g' pyproject.toml
    fi

    if [ -f setup.cfg ]; then
        sed -i 's/setuptools_scm[<>=]*[0-9.]*/setuptools-scm/g' setup.cfg
        sed -i 's/setuptools>=[0-9]*/setuptools/g' setup.cfg
    fi
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
